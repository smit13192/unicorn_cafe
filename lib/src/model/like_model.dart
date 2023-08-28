import 'package:unicorn_cafe/src/entity/like_entity.dart';

class LikeModel extends LikeEntity {
  const LikeModel({required super.lid, required super.pid});

  factory LikeModel.fromMap(Map<String, dynamic> json) {
    return LikeModel(
      lid: json['lid'],
      pid: json['pid'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'lid': lid,
      'pid': pid,
    };
  }
}
