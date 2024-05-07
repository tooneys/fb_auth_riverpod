import 'dart:async';

import 'package:fb_auth_riverpod/config/router/router_names.dart';
import 'package:fb_auth_riverpod/constants/firebase_contants.dart';
import 'package:fb_auth_riverpod/models/custom_error.dart';
import 'package:fb_auth_riverpod/repositories/auth_repository_provider.dart';
import 'package:fb_auth_riverpod/utils/error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class VerifyEmailPage extends ConsumerStatefulWidget {
  const VerifyEmailPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _VerifyEmailPageState();
}

class _VerifyEmailPageState extends ConsumerState<VerifyEmailPage> {
  Timer? timer;

  @override
  void initState() {
    super.initState();
    sendEmailVerification();
    timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      checkEmailVerified();
    });
  }

  Future<void> sendEmailVerification() async {
    try {
      await ref.read(authRepositoryProvider).sendVerifyEmail();
    } on CustomError catch (e) {
      if (!mounted) return;
      errorDialog(context, e);
    }
  }

  Future<void> checkEmailVerified() async {
    final goRouter = GoRouter.of(context);

    void errorDialogRef(CustomError e) {
      errorDialog(context, e);
    }

    try {
      await ref.read(authRepositoryProvider).reloadUser();

      if (fbAuth.currentUser!.emailVerified) {
        timer?.cancel();
        goRouter.goNamed(RouterNames.home);
      }
    } on CustomError catch (e) {
      errorDialogRef(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Text('${fbAuth.currentUser?.email}'),
                  const Text('위 메일로 확인 이메일이 발송되었습니다.'),
                  const Text('확인 이메일을 찾을 수 없는 경우,'),
                  RichText(
                    text: TextSpan(
                      text: '',
                      style: DefaultTextStyle.of(context)
                          .style
                          .copyWith(fontSize: 18),
                      children: const [
                        TextSpan(
                          text: '스팸 메일함을',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(text: ' 확인하세요.'),
                      ],
                    ),
                  ),
                  const Text('또는, 이메일이 정확한지 확인하세요.'),
                ],
              ),
            ),
            OutlinedButton(
              onPressed: () async {
                try {
                  await ref.read(authRepositoryProvider).signout();
                  timer?.cancel();
                } on CustomError catch (e) {
                  if (!context.mounted) return;
                  errorDialog(context, e);
                }
              },
              child: const Text('Cancel'),
            ),
          ],
        ),
      ),
    );
  }
}
