import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicorn_cafe/src/config/utils/either_result.dart';
import 'package:unicorn_cafe/src/config/utils/formz_status.dart';
import 'package:unicorn_cafe/src/model/cart_model.dart';
import 'package:unicorn_cafe/src/services/firebase_auth_services.dart';
import 'package:unicorn_cafe/src/services/firebase_cloud_services.dart';

part 'address_event.dart';
part 'address_state.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  final FirebaseAuthService _firebaseAuthService;
  final FirebaseCloudService _firebaseCloudService;

  AddressBloc({
    required FirebaseAuthService firebaseAuthService,
    required FirebaseCloudService firebaseCloudService,
  })  : _firebaseAuthService = firebaseAuthService,
        _firebaseCloudService = firebaseCloudService,
        super(const AddressState()) {
    on<GetDefaultEvent>(_getDefaultEvent);
    on<UsernameChangeEvent>(_usernameChangedEvent);
    on<EmailChangeEvent>(_emailChangedEvent);
    on<MobileNoChangeEvent>(_mobileNoChangedEvent);
    on<SubmitEvent>(_submitEvent);
  }

  FutureOr<void> _getDefaultEvent(
    GetDefaultEvent event,
    Emitter<AddressState> emit,
  ) {
    emit(
      state.copyWith(
        username: event.username,
        email: event.email,
        mobileNo: event.mobileNo,
      ),
    );
  }

  FutureOr<void> _usernameChangedEvent(
    UsernameChangeEvent event,
    Emitter<AddressState> emit,
  ) {
    emit(state.copyWith(username: event.username));
  }

  FutureOr<void> _emailChangedEvent(
    EmailChangeEvent event,
    Emitter<AddressState> emit,
  ) {
    emit(state.copyWith(email: event.email));
  }

  FutureOr<void> _mobileNoChangedEvent(
    MobileNoChangeEvent event,
    Emitter<AddressState> emit,
  ) {
    emit(state.copyWith(mobileNo: event.mobileno));
  }

  FutureOr<void> _submitEvent(
    SubmitEvent event,
    Emitter<AddressState> emit,
  ) async {
    emit(state.copyWith(status: FormzStatus.loading));
    String uid = _firebaseAuthService.uid;
    EitherResult<bool> orderResult = await _firebaseCloudService.saveOrders(
      uid,
      state.email,
      DateTime.now(),
      orders: event.orders,
      addressData: state.toMap(),
    );
    orderResult.fold(
      (l) {
        emit(state.copyWith(status: FormzStatus.failed, error: l));
      },
      (r) {
        emit(state.copyWith(status: FormzStatus.success));
      },
    );
  }
}
