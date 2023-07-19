import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:unicorn_cafe/src/config/utils/either_result.dart';

class FirebaseAuthService {
  Future<EitherResult<UserCredential>> logIn(
    String email,
    String password,
  ) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return right(userCredential);
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<EitherResult<UserCredential>> sighIn(
    String email,
    String password,
  ) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return right(userCredential);
    } catch (e) {
      return left(e.toString());
    }
  }
}
