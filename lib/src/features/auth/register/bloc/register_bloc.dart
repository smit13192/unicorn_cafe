import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicorn_cafe/src/config/utils/either_result.dart';
import 'package:unicorn_cafe/src/config/utils/formz_status.dart';
import 'package:unicorn_cafe/src/services/firebase_auth_services.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final FirebaseAuthService _firebaseAuthService;

  RegisterBloc({required FirebaseAuthService firebaseAuthService})
      : _firebaseAuthService = firebaseAuthService,
        super(const RegisterState()) {
    on<UsernameChangedEvent>(_usernameChangedEvent);
    on<EmailChangedEvent>(_emailChangedEvent);
    on<PasswordChangedEvent>(_passwordChangedEvent);
    on<ConfirmPasswordChangedEvent>(_confirmPasswordChangedEvent);
    on<PhoneNoChangedEvent>(_phoneNoChangedEvent);
    on<PasswordToggleEvent>(_passwordToggleEvent);
    on<ConfirmPasswordToggleEvent>(_confirmPasswordToggleEvent);
    on<RegisterSubmitEvent>(_registerSubmitEvent);
  }

  FutureOr<void> _usernameChangedEvent(
    UsernameChangedEvent event,
    Emitter<RegisterState> emit,
  ) {
    emit(state.copyWith(username: event.username));
  }

  FutureOr<void> _emailChangedEvent(
    EmailChangedEvent event,
    Emitter<RegisterState> emit,
  ) {
    emit(state.copyWith(email: event.email));
  }

  FutureOr<void> _passwordChangedEvent(
    PasswordChangedEvent event,
    Emitter<RegisterState> emit,
  ) {
    emit(state.copyWith(password: event.password));
  }

  FutureOr<void> _confirmPasswordChangedEvent(
    ConfirmPasswordChangedEvent event,
    Emitter<RegisterState> emit,
  ) {
    emit(state.copyWith(confirmPassword: event.confirmPassword));
  }

  FutureOr<void> _phoneNoChangedEvent(
    PhoneNoChangedEvent event,
    Emitter<RegisterState> emit,
  ) {
    emit(state.copyWith(phoneNo: event.phoneNo));
  }

  FutureOr<void> _passwordToggleEvent(
    PasswordToggleEvent event,
    Emitter<RegisterState> emit,
  ) {
    emit(state.copyWith(passwordObscureText: !state.passwordObscureText));
  }

  FutureOr<void> _confirmPasswordToggleEvent(
    ConfirmPasswordToggleEvent event,
    Emitter<RegisterState> emit,
  ) {
    emit(
      state.copyWith(
        confirmPasswordObscureText: !state.confirmPasswordObscureText,
      ),
    );
  }

  FutureOr<void> _registerSubmitEvent(
    RegisterSubmitEvent event,
    Emitter<RegisterState> emit,
  ) async {
    emit(state.copyWith(status: FormzStatus.loading));
    EitherResult<UserCredential> result =
        await _firebaseAuthService.sighIn(state.email, state.password);
    result.fold((error) {
      emit(
        state.copyWith(
          status: FormzStatus.failed,
          error: error,
        ),
      );
    }, (userCredential) {
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
    });
  }
}
