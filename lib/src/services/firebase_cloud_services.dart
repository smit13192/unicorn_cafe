import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:unicorn_cafe/src/config/string/app_string.dart';
import 'package:unicorn_cafe/src/model/like_model.dart';
import 'package:unicorn_cafe/src/model/product_model.dart';

class FirebaseCloudService {
  final FirebaseFirestore _instance = FirebaseFirestore.instance;
  Stream<List<ProductModel>> getSpecificTypeProduct(String type) {
    return _instance
        .collection(AppString.productColletion)
        .where('type', isEqualTo: type)
        .snapshots()
        .map<List<ProductModel>>(
          (event) => event.docs
              .map<ProductModel>(
                (product) => ProductModel.fromMap(product.data()),
              )
              .toList(),
        );
  }

  Stream<List<String>> getAllTypes() {
    return _instance
        .collection(AppString.productTypeColletion)
        .snapshots()
        .map<List<String>>(
          (event) => event.docs
              .map<String>(
                (type) => type.data()['type'],
              )
              .toList(),
        );
  }

  Stream<List<ProductModel>> getAllProducts({int? limit}) {
    if (limit == null) {
      return _instance
          .collection(AppString.productColletion)
          .snapshots()
          .map<List<ProductModel>>(
            (event) => event.docs
                .map<ProductModel>(
                  (product) => ProductModel.fromMap(product.data()),
                )
                .toList(),
          );
    }
    return _instance
        .collection(AppString.productColletion)
        .limit(limit)
        .snapshots()
        .map<List<ProductModel>>(
          (event) => event.docs
              .map<ProductModel>(
                (product) => ProductModel.fromMap(product.data()),
              )
              .toList(),
        );
  }

  Stream<List<LikeModel>> fetchLikes(String uid) {
    return _instance
        .collection(AppString.userCollection)
        .doc(uid)
        .collection(AppString.likeCollection)
        .snapshots()
        .map<List<LikeModel>>(
          (event) => event.docs
              .map<LikeModel>((e) => LikeModel.fromMap(e.data()))
              .toList(),
        );
  }

  void addLike(String uid, String pid) {
    final doc = _instance
        .collection(AppString.userCollection)
        .doc(uid)
        .collection(AppString.likeCollection)
        .doc();
    final LikeModel likeModel = LikeModel(lid: doc.id, pid: pid);
    doc.set(likeModel.toMap());
  }
  
  void removeLike(String uid, String lid) {
    _instance
        .collection(AppString.userCollection)
        .doc(uid)
        .collection(AppString.likeCollection)
        .doc(lid).delete();
  }
}
