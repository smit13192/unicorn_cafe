import 'package:equatable/equatable.dart';

class LikeEntity extends Equatable {
  final String lid;
  final String pid;

  const LikeEntity({
    required this.lid,
    required this.pid,
  });
  @override
  List<Object?> get props => [lid, pid];
}
