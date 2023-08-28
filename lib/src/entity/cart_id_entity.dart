import 'package:equatable/equatable.dart';

class CartIdEntity extends Equatable {
  final String pid;
  final String cid;

  const CartIdEntity({
    required this.pid,
    required this.cid,
  });

  @override
  List<Object?> get props => [pid, cid];
}
