part of 'address_bloc.dart';

class AddressState extends Equatable {
  final FormzStatus status;
  final String username;
  final String email;
  final String mobileNo;
  final String error;

  const AddressState({
    this.status = FormzStatus.pure,
    this.username = '',
    this.email = '',
    this.mobileNo = '',
    this.error = '',
  });

  AddressState copyWith({
    FormzStatus? status,
    String? username,
    String? email,
    String? mobileNo,
    String? error,
  }) {
    return AddressState(
      status: status ?? FormzStatus.pure,
      username: username ?? this.username,
      email: email ?? this.email,
      mobileNo: mobileNo ?? this.mobileNo,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
        status,
        username,
        email,
        mobileNo,
        error,
      ];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'email': email,
      'mobileNo': mobileNo,
    };
  }

  factory AddressState.fromMap(Map<String, dynamic> map) {
    return AddressState(
      status: FormzStatus.pure,
      username: map['username'] as String,
      email: map['email'] as String,
      mobileNo: map['mobileNo'] as String,
      error: '',
    );
  }
}
