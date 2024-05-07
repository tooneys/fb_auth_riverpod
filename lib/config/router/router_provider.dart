import 'package:fb_auth_riverpod/pages/content/geo/geo_page.dart';

import '../../constants/firebase_contants.dart';
import 'router_names.dart';
import '../../pages/auth/reset_password/reset_password_page.dart';
import '../../pages/auth/signin/signin_page.dart';
import '../../pages/auth/signup/signup_page.dart';
import '../../pages/auth/verify_email/verify_email_page.dart';
import '../../pages/content/change_password/change_password_page.dart';
import '../../pages/content/home/home_page.dart';
import '../../pages/splash/firebase_error_page.dart';
import '../../pages/splash/splash_page.dart';
import '../../repositories/auth_repository_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../pages/page_not_found.dart';

part 'router_provider.g.dart';

@riverpod
GoRouter router(RouterRef ref) {
  final authState = ref.watch(authStateStreamProvider);

  return GoRouter(
    initialLocation: '/splash',
    redirect: (context, state) {
      if (authState is AsyncLoading<User?>) {
        return '/splash';
      }

      if (authState is AsyncError<User?>) {
        print('error: ${authState.error.toString()}');
        return '/firebaseError';
      }

      final authenticated = authState.valueOrNull != null;
      final authenticating = state.matchedLocation == '/signin' ||
          state.matchedLocation == '/signup' ||
          state.matchedLocation == '/resetPassword';

      if (authenticated == false) {
        return authenticating ? null : '/signin';
      }

      if (!fbAuth.currentUser!.emailVerified) {
        return '/verifyEmail';
      }

      final verifyingEmail = state.matchedLocation == '/verifyEmail';
      final splashing = state.matchedLocation == '/splash';

      return (authenticating || verifyingEmail || splashing) ? '/home' : null;
    },
    routes: [
      GoRoute(
        path: '/splash',
        name: RouterNames.splash,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: '/firebaseError',
        name: RouterNames.firebaseError,
        builder: (context, state) => const FirebaseErrorPage(),
      ),
      GoRoute(
        path: '/signin',
        name: RouterNames.signin,
        builder: (context, state) => const SigninPage(),
      ),
      GoRoute(
        path: '/signup',
        name: RouterNames.signup,
        builder: (context, state) => const SignupPage(),
      ),
      GoRoute(
        path: '/resetPassword',
        name: RouterNames.resetPassword,
        builder: (context, state) => const ResetPasswordPage(),
      ),
      GoRoute(
        path: '/verifyEmail',
        name: RouterNames.verifyEmail,
        builder: (context, state) => const VerifyEmailPage(),
      ),
      GoRoute(
        path: '/home',
        name: RouterNames.home,
        builder: (context, state) => const HomePage(),
        routes: [
          GoRoute(
            path: 'changePassword',
            name: RouterNames.changePassword,
            builder: (context, state) => const ChangePasswordPage(),
          ),
        ],
      ),
      GoRoute(
        path: '/geo',
        name: RouterNames.geo,
        builder: (context, state) => const GeoLocationPage(),
      ),
    ],
    errorBuilder: (context, state) {
      return PageNotFound(
        errorMessage: state.error.toString(),
      );
    },
  );
}
