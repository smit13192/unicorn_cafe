part of 'address_bloc.dart';

class AddressState extends Equatable {
  final FormzStatus status;
  final String username;
  final String email;
  final String mobileNo;
  final String pincode;
  final String city;
  final String state;
  final String area;
  final String flat;
  final bool save;

  factory AddressState.initState() {
    return const AddressState(
      status: FormzStatus.pure,
      username: '',
      email: '',
      mobileNo: '',
      pincode: '',
      city: '',
      state: '',
      area: '',
      flat: '',
      save: false,
    );
  }

  const AddressState({
    required this.status,
    required this.username,
    required this.email,
    required this.mobileNo,
    required this.pincode,
    required this.city,
    required this.state,
    required this.area,
    required this.flat,
    required this.save,
  });

  AddressState copyWith({
    FormzStatus? status,
    String? username,
    String? email,
    String? mobileNo,
    String? pincode,
    String? city,
    String? state,
    String? area,
    String? flat,
    bool? save,
  }) {
    return AddressState(
      status: status ?? this.status,
      username: username ?? this.username,
      email: email ?? this.email,
      mobileNo: mobileNo ?? this.mobileNo,
      pincode: pincode ?? this.pincode,
      city: city ?? this.city,
      state: state ?? this.state,
      area: area ?? this.area,
      flat: flat ?? this.flat,
      save: save ?? this.save,
    );
  }

  @override
  List<Object?> get props =>
      [username, email, mobileNo, pincode, city, state, area, flat, save];
}
