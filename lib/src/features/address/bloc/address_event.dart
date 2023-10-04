part of 'address_bloc.dart';

abstract class AddressEvent extends Equatable {}

class GetDefaultEvent extends AddressEvent {
  final String username;
  final String email;
  final String mobileNo;

  GetDefaultEvent({
    required this.username,
    required this.email,
    required this.mobileNo,
  });

  @override
  List<Object?> get props => [username, email, mobileNo];
}

class UsernameChangeEvent extends AddressEvent {
  final String username;
  UsernameChangeEvent(this.username);

  @override
  List<Object?> get props => [username];
}

class EmailChangeEvent extends AddressEvent {
  final String email;
  EmailChangeEvent(this.email);

  @override
  List<Object?> get props => [email];
}

class MobileNoChangeEvent extends AddressEvent {
  final String mobileno;
  MobileNoChangeEvent(this.mobileno);

  @override
  List<Object?> get props => [mobileno];
}

class SubmitEvent extends AddressEvent {
  final List<CartModel> orders;
  SubmitEvent(this.orders);

  @override
  List<Object?> get props => [orders];
}
