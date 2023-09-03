import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicorn_cafe/src/model/product_model.dart';
import 'package:unicorn_cafe/src/services/firebase_cloud_services.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  StreamSubscription? _streamSubscription;
  final FirebaseCloudService _firebaseCloudService;

  SearchCubit({required FirebaseCloudService firebaseCloudService})
      : _firebaseCloudService = firebaseCloudService,
        super(const SearchState.initState());

  FutureOr<void> getAllProducts() {
    _streamSubscription = _firebaseCloudService
        .getAllProducts()
        .handleError((e) {})
        .listen((products) {
      emit(state.copyWith(allProducts: products));
    });
  }

  FutureOr<void> queryChange(String query) {
    List<ProductModel> filterProduct = state.allProducts
        .where(
          (element) =>
              element.title.contains(query) ||
              element.description.contains(query),
        )
        .toList();
    emit(state.copyWith(query: query, filterProduct: filterProduct));
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
