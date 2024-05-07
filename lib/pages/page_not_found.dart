// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fb_auth_riverpod/config/router/router_names.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PageNotFound extends StatelessWidget {
  final String errorMessage;
  const PageNotFound({
    Key? key,
    required this.errorMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              errorMessage,
              style: const TextStyle(fontSize: 20, color: Colors.red),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            OutlinedButton(
              onPressed: () => GoRouter.of(context).pushNamed(RouterNames.home),
              child: const Text('Home', style: TextStyle(fontSize: 20)),
            )
          ],
        ),
      ),
    );
  }
}
