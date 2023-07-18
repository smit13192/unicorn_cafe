part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {}

class UsernameChangedEvent extends RegisterEvent {
  final String username;

  UsernameChangedEvent(this.username);

  @override
  List<Object?> get props => [username];
}

class EmailChangedEvent extends RegisterEvent {
  final String email;

  EmailChangedEvent(this.email);

  @override
  List<Object?> get props => [email];
}

class PasswordChangedEvent extends RegisterEvent {
  final String password;

  PasswordChangedEvent(this.password);

  @override
  List<Object?> get props => [password];
}

class ConfirmPasswordChangedEvent extends RegisterEvent {
  final String confirmPassword;

  ConfirmPasswordChangedEvent(this.confirmPassword);

  @override
  List<Object?> get props => [confirmPassword];
}

class PhoneNoChangedEvent extends RegisterEvent {
  final String phoneNo;

  PhoneNoChangedEvent(this.phoneNo);

  @override
  List<Object?> get props => [phoneNo];
}

class PasswordToggleEvent extends RegisterEvent {
  @override
  List<Object?> get props => [];
}

class ConfirmPasswordToggleEvent extends RegisterEvent {
  @override
  List<Object?> get props => [];
}


class RegisterSubmitEvent extends RegisterEvent {
  @override
  List<Object?> get props => [];
}
