part of 'register_bloc.dart';

class RegisterState extends Equatable {
  final FormzStatus status;
  final String username;
  final String email;
  final String password;
  final String confirmPassword;
  final String phoneNo;
  final bool passwordObscureText;
  final bool confirmPasswordObscureText;
  final String error;

  const RegisterState({
    this.status = FormzStatus.pure,
    this.username = '',
    this.email = '',
    this.password = '',
    this.confirmPassword = '',
    this.phoneNo = '',
    this.passwordObscureText = true,
    this.confirmPasswordObscureText = true,
    this.error = '',
  });

  RegisterState copyWith({
    FormzStatus? status,
    String? username,
    String? email,
    String? password,
    String? confirmPassword,
    String? phoneNo,
    bool? passwordObscureText,
    bool? confirmPasswordObscureText,
    String? error,
  }) {
    return RegisterState(
      status: status ?? FormzStatus.pure,
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      phoneNo: phoneNo ?? this.phoneNo,
      passwordObscureText: passwordObscureText ?? this.passwordObscureText,
      confirmPasswordObscureText:
          confirmPasswordObscureText ?? this.confirmPasswordObscureText,
      error: error ?? this.error,
    );
  }

  @override
  List<Object> get props {
    return [
      status,
      username,
      email,
      password,
      confirmPassword,
      phoneNo,
      passwordObscureText,
      confirmPasswordObscureText,
      error,
    ];
  }
}
