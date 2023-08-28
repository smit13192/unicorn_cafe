import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicorn_cafe/src/model/like_model.dart';
import 'package:unicorn_cafe/src/services/firebase_auth_services.dart';
import 'package:unicorn_cafe/src/services/firebase_cloud_services.dart';

class ProductLikeCubit extends Cubit<List<LikeModel>> {
  final FirebaseAuthService _firebaseAuthService;
  final FirebaseCloudService _firebaseCloudService;
  StreamSubscription? subscription;

  ProductLikeCubit({
    required FirebaseAuthService firebaseAuthService,
    required FirebaseCloudService firebaseCloudService,
  })  : _firebaseAuthService = firebaseAuthService,
        _firebaseCloudService = firebaseCloudService,
        super(const []);

  void fetchLikes() {
    subscription = _firebaseCloudService
        .fetchLikes(_firebaseAuthService.uid)
        .listen((event) {
      emit(event);
    });
  }

  void addLikes(String pid) {
    _firebaseCloudService.addLike(_firebaseAuthService.uid, pid);
  }

  void removeLikes(String lid) {
    _firebaseCloudService.removeLike(_firebaseAuthService.uid, lid);
  }

  @override
  Future<void> close() {
    subscription?.cancel();
    return super.close();
  }
}
