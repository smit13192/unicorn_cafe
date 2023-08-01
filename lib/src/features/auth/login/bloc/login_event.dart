part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {}

class EmailChangedEvent extends LoginEvent {
  final String email;

  EmailChangedEvent(this.email);

  @override
  List<Object?> get props => [email];
}

class PasswordChangedEvent extends LoginEvent {
  final String password;

  PasswordChangedEvent(this.password);

  @override
  List<Object?> get props => [password];
}

class PasswordToggleEvent extends LoginEvent {
  @override
  List<Object?> get props => [];
}

class LoginSubmitEvent extends LoginEvent {
  @override
  List<Object?> get props => [];
}