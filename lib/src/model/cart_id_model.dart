import 'package:unicorn_cafe/src/entity/cart_id_entity.dart';

class CartIdModel extends CartIdEntity {
  const CartIdModel({
    required super.pid,
    required super.cid,
  });

  factory CartIdModel.fromMap(Map<String, dynamic> json) {
    return CartIdModel(
      pid: json['pid'],
      cid: json['cid'],
    );
  }
}
