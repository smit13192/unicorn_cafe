import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicorn_cafe/src/model/cart_model.dart';
import 'package:unicorn_cafe/src/model/product_model.dart';
import 'package:unicorn_cafe/src/services/firebase_auth_services.dart';
import 'package:unicorn_cafe/src/services/firebase_cloud_services.dart';

class UserCartCubit extends Cubit<List<CartModel>> {
  final FirebaseAuthService _firebaseAuthService;
  final FirebaseCloudService _firebaseCloudService;
  StreamSubscription? subscription;

  UserCartCubit({
    required FirebaseAuthService firebaseAuthService,
    required FirebaseCloudService firebaseCloudService,
  })  : _firebaseAuthService = firebaseAuthService,
        _firebaseCloudService = firebaseCloudService,
        super(const []);

  FutureOr<void> getCartItem() {
    subscription = _firebaseCloudService
        .getCartItem(_firebaseAuthService.uid)
        .listen((event) {
      emit(event);
    });
  }

  FutureOr<void> addCartItem(ProductModel product) {
    _firebaseCloudService.addCartItem(_firebaseAuthService.uid, product);
  }

  FutureOr<void> removeCartProduct(String cid) {
    _firebaseCloudService.removeCartItem(_firebaseAuthService.uid, cid);
  }

  FutureOr<void> addQuantity(String cid, int quantity) {
    _firebaseCloudService.addCartQuantity(
      _firebaseAuthService.uid,
      cid,
      quantity,
    );
  }

  FutureOr<void> removeQuantity(String cid, int quantity) {
    _firebaseCloudService.removeCartQuantity(
      _firebaseAuthService.uid,
      cid,
      quantity,
    );
  }

  double get totalPrice {
    return state.fold<double>(0.0, (previousValue, element) {
      return previousValue += element.price * element.quantity;
    });
  }

  @override
  Future<void> close() {
    subscription?.cancel();
    return super.close();
  }
}
