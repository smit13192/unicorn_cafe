part of 'address_bloc.dart';

abstract class AddressEvent extends Equatable {}

class GetDefaultEvent extends AddressEvent {
  @override
  List<Object?> get props => [];
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

class PincodeChangeEvent extends AddressEvent {
  final String pincode;
  PincodeChangeEvent(this.pincode);

  @override
  List<Object?> get props => [pincode];
}

class CityChangeEvent extends AddressEvent {
  final String city;
  CityChangeEvent(this.city);

  @override
  List<Object?> get props => [city];
}

class StateChangeEvent extends AddressEvent {
  final String state;
  StateChangeEvent(this.state);

  @override
  List<Object?> get props => [state];
}

class AreaChangeEvent extends AddressEvent {
  final String area;
  AreaChangeEvent(this.area);

  @override
  List<Object?> get props => [area];
}

class FlatNameChangeEvent extends AddressEvent {
  final String flatname;
  FlatNameChangeEvent(this.flatname);

  @override
  List<Object?> get props => [flatname];
}

class AddressSaveChangeEvent extends AddressEvent {
  final bool markAsDefault;
  AddressSaveChangeEvent(this.markAsDefault);

  @override
  List<Object?> get props => [markAsDefault];
}

class SubmitEvent extends AddressEvent {
  @override
  List<Object?> get props => [];
}
