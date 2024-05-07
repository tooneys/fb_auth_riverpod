import '../constants/firebase_contants.dart';
import 'auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_repository_provider.g.dart';

@riverpod
AuthRepository authRepository(AuthRepositoryRef ref) {
  print('[authRepositoryProvider] initialized');
  ref.onDispose(() {
    print('[authRepositoryProvider] disposed');
  });
  return AuthRepository();
}

@riverpod
Stream<User?> authStateStream(AuthStateStreamRef ref) {
  print('[authStateStreamProvider] initialized');
  ref.onDispose(() {
    print('[authStateStreamProvider] disposed');
  });
  return fbAuth.authStateChanges();
}
