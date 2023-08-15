import 'package:unicorn_cafe/src/model/product_model.dart';

class CartModel extends ProductModel {
  final int quantity;
  final String cid;

  const CartModel({
    required super.pid,
    required super.title,
    required super.subtitle,
    required super.description,
    required super.type,
    required super.image,
    required super.price,
    required super.star,
    required super.review,
    required this.quantity,
    required this.cid,
  });

  factory CartModel.fromMap(Map<String, dynamic> json) {
    return CartModel(
      pid: json['pid'] as String,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
      description: json['description'] as String,
      type: json['type'] as String,
      image: json['image'] as String,
      price: json['price'] as num,
      star: json['star'] as num,
      review: json['review'] as num,
      quantity: json['quantity'] as int,
      cid: json['cid'] as String,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'pid': pid,
      'title': title,
      'subtitle': subtitle,
      'description': description,
      'type': type,
      'image': image,
      'price': price,
      'star': star,
      'review': review,
      'quantity': quantity,
      'cid': cid,
    };
  }
}
