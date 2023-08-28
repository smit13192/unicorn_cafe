part of 'user_cart_id_cubit.dart';

class UserCartIdState extends Equatable {
  final List<CartIdModel> carts;

  const UserCartIdState({
    required this.carts,
  });

  List<String> get pid => carts.map((e) => e.pid).toList();

  List<String> get cid => carts.map((e) => e.cid).toList();

  String getCid(String pid) {
    return carts.where((element) => element.pid == pid).toList().first.cid;
  }

  @override
  List<Object?> get props => [carts];
}
