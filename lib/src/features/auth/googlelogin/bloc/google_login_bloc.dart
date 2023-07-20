import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicorn_cafe/src/config/utils/either_result.dart';
import 'package:unicorn_cafe/src/config/utils/formz_status.dart';
import 'package:unicorn_cafe/src/services/firebase_auth_services.dart';

part 'google_login_event.dart';
part 'google_login_state.dart';

class GoogleLoginBloc extends Bloc<GoogleLoginEvent, GoogleLoginState> {
  final FirebaseAuthService _firebaseAuthService;
  GoogleLoginBloc({required FirebaseAuthService firebaseAuthService})
      : _firebaseAuthService = firebaseAuthService,
        super(GoogleLoginState()) {
    on<GoogleLoginEvent>(_googleLoginEvent);
  }

  FutureOr<void> _googleLoginEvent(
    GoogleLoginEvent event,
    Emitter<GoogleLoginState> emit,
  ) async {
    emit(state.copyWith(status: FormzStatus.loading));
    EitherResult<UserCredential> result =
        await _firebaseAuthService.googleLogin();
    result.fold(
      (error) => emit(state.copyWith(status: FormzStatus.failed, error: error)),
      (credential) => emit(state.copyWith(status: FormzStatus.success)),
    );
  }
}
