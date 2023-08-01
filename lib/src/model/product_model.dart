import 'package:unicorn_cafe/src/entity/product_entity.dart';

class ProductModel extends ProductEntity {
  const ProductModel({
    required super.pid,
    required super.title,
    required super.subtitle,
    required super.description,
    required super.type,
    required super.image,
    required super.price,
    required super.star,
    required super.review,
  });

  factory ProductModel.fromMap(Map<String, dynamic> json) {
    return ProductModel(
      pid: json['pid'] as String,
      title: json['title'] as String ,
      subtitle: json['subtitle'] as String,
      description: json['description'] as String,
      type: json['type'] as String,
      image: json['image'] as String,
      price: json['price'] as num,
      star: json['star'] as num,
      review: json['review'] as num,
    );
  }
}
