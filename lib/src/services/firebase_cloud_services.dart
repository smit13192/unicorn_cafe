import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:unicorn_cafe/src/config/string/app_string.dart';
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
}
