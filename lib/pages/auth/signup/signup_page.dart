import 'package:fb_auth_riverpod/config/router/router_names.dart';
import 'package:fb_auth_riverpod/pages/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../widgets/form_field.dart';
import '../../../models/custom_error.dart';
import '../../../utils/error_dialog.dart';

import 'signup_provider.dart';

class SignupPage extends ConsumerStatefulWidget {
  const SignupPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignupPageState();
}

class _SignupPageState extends ConsumerState<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _authValidateMode = AutovalidateMode.disabled;
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    setState(() {
      _authValidateMode = AutovalidateMode.always;
    });

    final form = _formKey.currentState;

    if (form == null || !form.validate()) return;

    print(
        'name: ${_nameController.text}, email: ${_emailController.text}, password: ${_passwordController.text}');

    ref.read(signupProvider.notifier).signup(
          name: _nameController.text.trim(),
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<void>>(signupProvider, (previous, next) {
      next.whenOrNull(
        error: (error, stackTrace) {
          return errorDialog(context, (error as CustomError));
        },
      );
    });

    final signupState = ref.watch(signupProvider);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Form(
              key: _formKey,
              autovalidateMode: _authValidateMode,
              child: ListView(
                shrinkWrap: true,
                reverse: true,
                children: [
                  const FlutterLogo(size: 100),
                  const SizedBox(height: 20),
                  NameFormField(nameController: _nameController),
                  const SizedBox(height: 20),
                  EmailFormField(emailController: _emailController),
                  const SizedBox(height: 20),
                  PasswordFormField(
                    passwordController: _passwordController,
                    labelText: '비밀번호',
                  ),
                  const SizedBox(height: 20),
                  ConfirmPasswordFormField(
                    passwordController: _passwordController,
                    labelText: '비밀번호 확인',
                  ),
                  const SizedBox(height: 20),
                  CustomFilledButton(
                    onPressed: signupState.maybeWhen(
                      loading: () => null,
                      orElse: () => _submit,
                    ),
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                    child: Text(
                      signupState.maybeWhen(
                        loading: () => '저장중입니다...',
                        orElse: () => '회원가입',
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('이미 가입하셨나요? '),
                      CustomTextButton(
                        onPressed: signupState.maybeWhen(
                          loading: () => null,
                          orElse: () => () => GoRouter.of(context)
                              .pushNamed(RouterNames.signin),
                        ),
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        child: const Text('로그인'),
                      ),
                    ],
                  )
                ].reversed.toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
