import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicorn_cafe/src/config/utils/formz_status.dart';
import 'package:unicorn_cafe/src/services/firebase_auth_services.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final FirebaseAuthService _firebaseAuthService;
  LoginBloc({required FirebaseAuthService firebaseAuthService})
      : _firebaseAuthService = firebaseAuthService,
        super(const LoginState()) {
    on<EmailChangedEvent>(_emailChangedEvent);
    on<PasswordChangedEvent>(_passwordChangedEvent);
    on<PasswordToggleEvent>(_passwordToggleEvent);
    on<LoginSubmitEvent>(_loginSubmitEvent);
  }

  FutureOr<void> _emailChangedEvent(
    EmailChangedEvent event,
    Emitter<LoginState> emit,
  ) {
    emit(state.copyWith(email: event.email));
  }

  FutureOr<void> _passwordChangedEvent(
    PasswordChangedEvent event,
    Emitter<LoginState> emit,
  ) {
    emit(state.copyWith(password: event.password));
  }

  FutureOr<void> _passwordToggleEvent(
    PasswordToggleEvent event,
    Emitter<LoginState> emit,
  ) {
    emit(state.copyWith(passwordObscureText: !state.passwordObscureText));
  }

  FutureOr<void> _loginSubmitEvent(
    LoginSubmitEvent event,
    Emitter<LoginState> emit,
  ) async {
    try {
      UserCredential userCredential =
          await _firebaseAuthService.logIn(state.email, state.password);
      if (userCredential.user == null) {
        emit(
          state.copyWith(
            status: FormzStatus.failed,
            error: 'Some error occurred',
          ),
        );
        return;
      }
      emit(state.copyWith(status: FormzStatus.success));
    } catch (e) {
      emit(state.copyWith(status: FormzStatus.failed, error: e.toString()));
    }
  }
}
