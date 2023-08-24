import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicorn_cafe/src/config/utils/formz_status.dart';

part 'address_event.dart';
part 'address_state.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  AddressBloc() : super(AddressState.initState()) {
    on<GetDefaultEvent>(_getDefaultEvent);
    on<UsernameChangeEvent>(_usernameChangedEvent);
    on<EmailChangeEvent>(_emailChangedEvent);
    on<MobileNoChangeEvent>(_mobileNoChangedEvent);
    on<PincodeChangeEvent>(_pincodeChangedEvent);
    on<CityChangeEvent>(_cityChangesEvent);
    on<StateChangeEvent>(_stateChangedEvent);
    on<AreaChangeEvent>(_areaChangedEvent);
    on<FlatNameChangeEvent>(_flatNameChangedEvent);
    on<AddressSaveChangeEvent>(_addressSaveChangedEvent);
    on<SubmitEvent>(_submitEvent);
  }

  FutureOr<void> _getDefaultEvent(
    GetDefaultEvent event,
    Emitter<AddressState> emit,
  ) {}

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

  FutureOr<void> _pincodeChangedEvent(
    PincodeChangeEvent event,
    Emitter<AddressState> emit,
  ) {
    emit(state.copyWith(pincode: event.pincode));
  }

  FutureOr<void> _cityChangesEvent(
    CityChangeEvent event,
    Emitter<AddressState> emit,
  ) {
    emit(state.copyWith(city: event.city));
  }

  FutureOr<void> _stateChangedEvent(
    StateChangeEvent event,
    Emitter<AddressState> emit,
  ) {
    emit(state.copyWith(state: event.state));
  }

  FutureOr<void> _areaChangedEvent(
    AreaChangeEvent event,
    Emitter<AddressState> emit,
  ) {
    emit(state.copyWith(area: event.area));
  }

  FutureOr<void> _flatNameChangedEvent(
    FlatNameChangeEvent event,
    Emitter<AddressState> emit,
  ) {
    emit(state.copyWith(flat: event.flatname));
  }

  FutureOr<void> _addressSaveChangedEvent(
    AddressSaveChangeEvent event,
    Emitter<AddressState> emit,
  ) {
    emit(state.copyWith(save: event.markAsDefault));
  }

  FutureOr<void> _submitEvent(
    SubmitEvent event,
    Emitter<AddressState> emit,
  ) {}
}
