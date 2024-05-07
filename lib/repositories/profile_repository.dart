import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fb_auth_riverpod/constants/firebase_contants.dart';
import 'package:fb_auth_riverpod/models/app_user.dart';
import 'package:fb_auth_riverpod/repositories/handle_exception.dart';

class ProfileRepository {
  Future<AppUser> getProfile({required String uid}) async {
    // await Future.delayed(const Duration(seconds: 5));

    try {
      final DocumentSnapshot appUserDoc = await usersCollection.doc(uid).get();

      if (appUserDoc.exists) {
        final appUser = AppUser.fromDoc(appUserDoc);
        return appUser;
      }

      throw '사용자 정보가 없습니다.';
    } catch (e) {
      throw handleException(e);
    }
  }
}
