import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicorn_cafe/src/services/firebase_cloud_services.dart';

class CategoryTypeCubit extends Cubit<List<String>> {
  final FirebaseCloudService _firebaseCloudService;
  StreamSubscription? subscription;
  CategoryTypeCubit(FirebaseCloudService firebaseCloudService)
      : _firebaseCloudService = firebaseCloudService,
        super([]);

  void getTypes() {
    subscription = _firebaseCloudService.getAllTypes().handleError((e) {
      emit([]);
    }).listen(
      (event) {
        emit(event);
      },
    );
  }

  @override
  Future<void> close() {
    subscription?.cancel();
    return super.close();
  }
}
