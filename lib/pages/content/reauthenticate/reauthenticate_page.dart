import 'package:fb_auth_riverpod/models/custom_error.dart';
import 'package:fb_auth_riverpod/repositories/auth_repository_provider.dart';
import 'package:fb_auth_riverpod/utils/error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../widgets/buttons.dart';
import '../../widgets/form_field.dart';

class ReauthenticatePage extends ConsumerStatefulWidget {
  const ReauthenticatePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ReauthenticatePageState();
}

class _ReauthenticatePageState extends ConsumerState<ReauthenticatePage> {
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _authValidateMode = AutovalidateMode.disabled;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool submitting = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() async {
    setState(() {
      _authValidateMode = AutovalidateMode.always;
    });

    final form = _formKey.currentState;

    if (form == null || !form.validate()) return;

    setState(() {
      submitting = true;
    });

    try {
      final router = Navigator.of(context);

      await ref.read(authRepositoryProvider).reauthenticateWithCredential(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
          );

      setState(() {
        submitting = false;
      });

      router.pop('success');
    } on CustomError catch (e) {
      setState(() {
        submitting = false;
      });
      if (!mounted) return;
      errorDialog(context, e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Reauthenticate'),
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
                    '보안에 민감한 작업입니다. 최근에 로그인한 상태여야 합니다.',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  EmailFormField(emailController: _emailController),
                  const SizedBox(height: 20),
                  PasswordFormField(
                    passwordController: _passwordController,
                    labelText: '비밀번호',
                  ),
                  const SizedBox(height: 20),
                  CustomFilledButton(
                    onPressed: submitting ? null : _submit,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                    child: Text(
                      submitting ? '재인증중...' : '재인증',
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
