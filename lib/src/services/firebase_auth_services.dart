import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
    } on FirebaseAuthException catch (e) {
      String error = getErrorMessage(e.code);
      return left(error);
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
    } on FirebaseAuthException catch (e) {
      String error = getErrorMessage(e.code);
      return left(error);
    }
  }

  Future<EitherResult<UserCredential>> googleLogin() async {
    try {
      GoogleSignIn googleSighin = GoogleSignIn();
      GoogleSignInAccount? account = await googleSighin.signIn();
      if (account == null) {
        return left('Choose email id');
      }
      GoogleSignInAuthentication auth = await account.authentication;
      OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: auth.accessToken,
        idToken: auth.idToken,
      );
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      return right(userCredential);
    } on FirebaseAuthException catch (e) {
      String error = getErrorMessage(e.code);
      return left(error);
    }
  }

  bool get isLogin => FirebaseAuth.instance.currentUser != null;

  String getErrorMessage(String errorCode) {
    switch (errorCode) {
      case 'email-already-exists':
        return 'Email id already exist';
      case 'user-not-found':
        return 'Email id not exist';
      case 'wrong-password':
        return 'Invalid password';
      default:
        return 'Some error accurred';
    }
  }
}
