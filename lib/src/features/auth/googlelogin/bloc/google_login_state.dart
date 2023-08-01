part of 'google_login_bloc.dart';

class GoogleLoginState {
  FormzStatus status;
  String error;

  GoogleLoginState({
    this.status = FormzStatus.pure,
    this.error = '',
  });

  GoogleLoginState copyWith({
    FormzStatus? status,
    String? error,
  }) {
    return GoogleLoginState(
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}
