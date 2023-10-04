import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:unicorn_cafe/src/config/string/app_string.dart';
import 'package:unicorn_cafe/src/config/utils/either_result.dart';
import 'package:unicorn_cafe/src/model/cart_id_model.dart';
import 'package:unicorn_cafe/src/model/cart_model.dart';
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

  Future<ProductModel> getProduct(String uid) async {
    final snapshot =
        await _instance.collection(AppString.productColletion).doc(uid).get();
    return ProductModel.fromMap(snapshot.data() as Map<String, dynamic>);
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
        .doc(lid)
        .delete();
  }

  Stream<List<CartModel>> getCartItem(String uid) {
    return _instance
        .collection(AppString.userCollection)
        .doc(uid)
        .collection(AppString.cartCollection)
        .snapshots()
        .map<List<CartModel>>(
          (event) => event.docs
              .map<CartModel>((e) => CartModel.fromMap(e.data()))
              .toList(),
        );
  }

  Stream<List<CartIdModel>> getCartItemProductId(String uid) {
    return _instance
        .collection(AppString.userCollection)
        .doc(uid)
        .collection(AppString.cartCollection)
        .snapshots()
        .map<List<CartIdModel>>(
          (event) => event.docs
              .map<CartIdModel>((e) => CartIdModel.fromMap(e.data()))
              .toList(),
        );
  }

  void addCartItem(String uid, ProductModel product) {
    final doc = _instance
        .collection(AppString.userCollection)
        .doc(uid)
        .collection(AppString.cartCollection)
        .doc();
    doc.set({...product.toMap(), 'cid': doc.id, 'quantity': 1});
  }

  void removeCartItem(String uid, String cid) {
    _instance
        .collection(AppString.userCollection)
        .doc(uid)
        .collection(AppString.cartCollection)
        .doc(cid)
        .delete();
  }

  void addCartQuantity(String uid, String cid, int quantity) {
    _instance
        .collection(AppString.userCollection)
        .doc(uid)
        .collection(AppString.cartCollection)
        .doc(cid)
        .update({'quantity': quantity});
  }

  void removeCartQuantity(String uid, String cid, int quantity) {
    _instance
        .collection(AppString.userCollection)
        .doc(uid)
        .collection(AppString.cartCollection)
        .doc(cid)
        .update({'quantity': quantity});
  }

  Future<EitherResult<bool>> saveOrders(
    String uid,
    String email,
    DateTime date, {
    required List<CartModel> orders,
    required Map<String, dynamic> addressData,
  }) async {
    try {
      final doc = _instance.collection(AppString.orderCollection).doc();
      await _instance
          .collection(AppString.addressCollection)
          .doc(uid)
          .set(addressData);
      List<Map<String, dynamic>> orderData =
          orders.map((e) => e.toMap()).toList();
      await doc.set({
        'order': orderData,
        'uid': uid,
        'email': email,
        'oid': doc.id,
        'date': Timestamp.fromDate(date),
      });
      return right(true);
    } catch (e) {
      return left('Order not save successfully');
    }
  }

  Future<EitherResult<Map<String, dynamic>>> getUserAddress(String uid) async {
    try {
      final snapshot = await _instance
          .collection(AppString.addressCollection)
          .doc(uid)
          .get();
      if (snapshot.exists) {
        if (snapshot.data() != null) {
          return right(snapshot.data()!);
        }
      }
      return left('Address is not save in our database');
    } catch (e) {
      return left('Address not save successfully');
    }
  }
}
