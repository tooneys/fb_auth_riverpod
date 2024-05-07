import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../config/router/router_names.dart';
import '../../../models/custom_error.dart';
import '../../../utils/error_dialog.dart';
import '../../widgets/buttons.dart';
import '../../widgets/form_field.dart';
import 'signin_provider.dart';

class SigninPage extends ConsumerStatefulWidget {
  const SigninPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SigninPageState();
}

class _SigninPageState extends ConsumerState<SigninPage> {
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _authValidateMode = AutovalidateMode.disabled;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
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

    ref.read(signinProvider.notifier).signin(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<void>>(signinProvider, (previous, next) {
      next.whenOrNull(
        error: (error, stackTrace) {
          return errorDialog(context, (error as CustomError));
        },
      );
    });

    final signinState = ref.watch(signinProvider);

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
                  const FlutterLogo(size: 150),
                  const SizedBox(height: 20),
                  EmailFormField(emailController: _emailController),
                  const SizedBox(height: 20),
                  PasswordFormField(
                    passwordController: _passwordController,
                    labelText: '비밀번호',
                  ),
                  const SizedBox(height: 20),
                  CustomFilledButton(
                    onPressed: signinState.maybeWhen(
                      loading: () => null,
                      orElse: () => _submit,
                    ),
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                    child: Text(
                      signinState.maybeWhen(
                        loading: () => '로그인중입니다...',
                        orElse: () => '로그인',
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('가입 안하셨나요? '),
                      CustomTextButton(
                        onPressed: signinState.maybeWhen(
                          loading: () => null,
                          orElse: () => () => GoRouter.of(context)
                              .pushNamed(RouterNames.signup),
                        ),
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        child: const Text('회원가입'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  CustomTextButton(
                    onPressed: signinState.maybeWhen(
                      loading: () => null,
                      orElse: () => () => GoRouter.of(context)
                          .pushNamed(RouterNames.resetPassword),
                    ),
                    foregroundColor: Colors.red,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    child: const Text('비밀번호를 잊으셨나요?'),
                  ),
                ].reversed.toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
