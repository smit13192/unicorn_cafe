import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicorn_cafe/src/model/product_model.dart';
import 'package:unicorn_cafe/src/services/firebase_cloud_services.dart';

class ProductCubit extends Cubit<List<ProductModel>> {
  final FirebaseCloudService _firebaseCloudService;
  StreamSubscription? subscription;
  ProductCubit(FirebaseCloudService firebaseCloudService)
      : _firebaseCloudService = firebaseCloudService,
        super([]);

  void getAllProduct(int? limit) {
    subscription = _firebaseCloudService.getAllProducts(limit: limit).handleError((e) {
      emit([]);
    }).listen((event) {
      emit(event);
    });
  }

  @override
  Future<void> close() {
    subscription?.cancel();
    return super.close();
  }
}
