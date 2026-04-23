import 'package:firebase_auth/firebase_auth.dart';
import 'package:notes_app_assessment/core/errors/app_exception.dart';

class TokenService {
  final FirebaseAuth _firebaseAuth;

  TokenService({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  Future<String?> getIdToken({bool forceRefresh = false}) async {
    try {
      return await _firebaseAuth.currentUser?.getIdToken(forceRefresh);
    } on FirebaseAuthException catch (e) {
      throw AuthException(
        message: 'Failed to retrieve token.',
        code: e.code,
      );
    }
  }

  Future<void> refreshToken() async {
    await getIdToken(forceRefresh: true);
  }

  bool get hasValidUser => _firebaseAuth.currentUser != null;
}
