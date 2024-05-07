import 'package:fb_auth_riverpod/pages/content/change_password/change_password_provider.dart';
import 'package:fb_auth_riverpod/pages/content/reauthenticate/reauthenticate_page.dart';
import 'package:fb_auth_riverpod/repositories/auth_repository_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/custom_error.dart';
import '../../../utils/error_dialog.dart';
import '../../widgets/buttons.dart';
import '../../widgets/form_field.dart';

class ChangePasswordPage extends ConsumerStatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ChangePasswordPageState();
}

class _ChangePasswordPageState extends ConsumerState<ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _authValidateMode = AutovalidateMode.disabled;
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    setState(() {
      _authValidateMode = AutovalidateMode.always;
    });

    final form = _formKey.currentState;

    if (form == null || !form.validate()) return;

    ref.read(changePasswordProvider.notifier).changePassword(
          password: _passwordController.text.trim(),
        );
  }

  void _processSuccess() async {
    try {
      await ref.read(authRepositoryProvider).signout();
    } on CustomError catch (e) {
      if (!mounted) return;
      errorDialog(context, e);
    }
  }

  void _processRequiresRecentLogin() async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => const ReauthenticatePage(),
      ),
    );

    if (result == 'success') {
      scaffoldMessenger.showSnackBar(
        const SnackBar(
          content: Text('재인증에 성공하였습니다.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<void>>(changePasswordProvider, (previous, next) {
      next.whenOrNull(
        error: (error, stackTrace) {
          final err = error as CustomError;

          if (err.code == 'requires-recent-login') {
            _processRequiresRecentLogin();
          } else {
            errorDialog(context, err);
          }
        },
        data: (_) => _processSuccess(),
      );
    });

    final changePwdState = ref.watch(changePasswordProvider);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('비밀번호 변경'),
        ),
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
                  const Text(
                    '만약 비밀번호 변경시 \n로그인 화면으로 넘어갑니다.',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(height: 20),
                  PasswordFormField(
                    passwordController: _passwordController,
                    labelText: '비밀번호',
                  ),
                  const SizedBox(height: 20),
                  ConfirmPasswordFormField(
                    passwordController: _passwordController,
                    labelText: '확인 비밀번호',
                  ),
                  const SizedBox(height: 20),
                  CustomFilledButton(
                    onPressed: changePwdState.maybeWhen(
                      loading: () => null,
                      orElse: () => _submit,
                    ),
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                    child: Text(
                      changePwdState.maybeWhen(
                        loading: () => '변경중입니다...',
                        orElse: () => '비밀번호 변경',
                      ),
                    ),
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
