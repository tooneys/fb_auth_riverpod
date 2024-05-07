import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../constants/firebase_contants.dart';
import 'handle_exception.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  User? get currentUser => fbAuth.currentUser;

  Future<void> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      // 이메일 유저인증 저장하기
      final userCredential = await fbAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // 저장된 유저인증정보 받아오기
      final signedInUser = userCredential.user!;

      await usersCollection.doc(signedInUser.uid).set({
        'name': name,
        'email': email,
      });
    } catch (e) {
      throw handleException(e);
    }
  }

  Future<void> signin({
    required String email,
    required String password,
  }) async {
    try {
      await fbAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      throw handleException(e);
    }
  }

  Future<void> signout() async {
    try {
      await fbAuth.signOut();
    } catch (e) {
      throw handleException(e);
    }
  }

  Future<void> changePassword({required String password}) async {
    try {
      await currentUser!.updatePassword(password);
    } catch (e) {
      throw handleException(e);
    }
  }

  Future<void> sendPasswordReset({required String email}) async {
    try {
      await fbAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      throw handleException(e);
    }
  }

  Future<void> sendVerifyEmail() async {
    try {
      await currentUser!.sendEmailVerification();
    } catch (e) {
      throw handleException(e);
    }
  }

  Future<void> reloadUser() async {
    try {
      await currentUser!.reload();
    } catch (e) {
      throw handleException(e);
    }
  }

  Future<void> reauthenticateWithCredential({
    required String email,
    required String password,
  }) async {
    try {
      await currentUser!.reauthenticateWithCredential(
        EmailAuthProvider.credential(email: email, password: password),
      );
    } catch (e) {
      throw handleException(e);
    }
  }

  Future<void> saveTokenToDatabase() async {
    // 클라우드메세지에서 토큰받아오기
    final fcmToken = await FirebaseMessaging.instance.getToken();

    if (currentUser == null) return;

    //로그인된 유저아이디 정보
    String uid = currentUser!.uid;

    await usersCollection.doc(uid).update({
      'tokens': FieldValue.arrayUnion([fcmToken]),
    });
  }
}
