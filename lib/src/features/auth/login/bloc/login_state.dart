part of 'login_bloc.dart';

class LoginState extends Equatable {
  final FormzStatus status;
  final String email;
  final String password;
  final bool passwordObscureText;
  final String error;

  const LoginState({
    this.status = FormzStatus.pure,
    this.email = '',
    this.password = '',
    this.passwordObscureText = false,
    this.error = '',
  });

  LoginState copyWith({
    FormzStatus? status,
    String? email,
    String? password,
    bool? passwordObscureText,
    String? error,
  }) {
    return LoginState(
      status: status ?? FormzStatus.pure,
      email: email ?? this.email,
      password: password ?? this.password,
      passwordObscureText: passwordObscureText ?? this.passwordObscureText,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props =>
      [email, password, status, passwordObscureText, error];
}
