import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicorn_cafe/src/model/cart_id_model.dart';
import 'package:unicorn_cafe/src/services/firebase_auth_services.dart';
import 'package:unicorn_cafe/src/services/firebase_cloud_services.dart';

part 'user_cart_id_state.dart';

class UserCartIdCubit extends Cubit<UserCartIdState> {
  final FirebaseAuthService _firebaseAuthService;
  final FirebaseCloudService _firebaseCloudService;
  StreamSubscription? subscription;

  UserCartIdCubit({
    required FirebaseAuthService firebaseAuthService,
    required FirebaseCloudService firebaseCloudService,
  })  : _firebaseAuthService = firebaseAuthService,
        _firebaseCloudService = firebaseCloudService,
        super(const UserCartIdState(carts: []));

  void getAllId() {
    String uid = _firebaseAuthService.uid;
    _firebaseCloudService.getCartItemProductId(uid).listen((event) {
      emit(UserCartIdState(carts: event));
    });
  }
}
