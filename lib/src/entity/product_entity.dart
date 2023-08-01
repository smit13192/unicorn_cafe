import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final String pid;
  final String title;
  final String subtitle;
  final String description;
  final String type;
  final String image;
  final num price;
  final num star;
  final num review;

  const ProductEntity({
    required this.pid,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.type,
    required this.image,
    required this.price,
    required this.star,
    required this.review,
  });

  @override
  List<Object?> get props =>
      [pid, title, subtitle, description, type, image, price, star, review];
}
