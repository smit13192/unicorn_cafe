import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  Future<UserCredential> logIn(String email, String password) async {
    try {
      return FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<UserCredential> sighIn(String email, String password) async {
    try {
      return FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      rethrow;
    }
  }
}
