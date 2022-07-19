import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:new_bus_information/application/models/bus/bus_status.dart';
import 'package:new_bus_information/application/models/driver/driver_status.dart';
import 'package:new_bus_information/application/models/driver/shift_work.dart';
import 'package:new_bus_information/application/models/search_condidate_type.dart';

part 'filter_terms_event.dart';
part 'filter_terms_state.dart';

class FilterTermsBloc extends Bloc<FilterTermsEvent, FilterTermsState> {
  FilterTermsBloc() : super(FilterTermsState.initial()) {
    on<SetSearchCondidateEvent>(changeSearchCondidate);
    on<SetBusStatusCondidateEvent>(changeBusStatusCondidate);
    on<SetDriverStatusCondidateEvent>(changeDriverStatusCondidate);
    on<SetDriverShiftCondidateEvent>(changeDriverShiftCondidate);
    on<SetSecondDriverStatusCondidateEvent>(changeSecondDriverStatusCondidate);
    on<SetSecondDriverShiftCondidateEvent>(changeSecondDriverShiftCondidate);
  }

  FutureOr<void> changeSearchCondidate(
    SetSearchCondidateEvent event,
    Emitter<FilterTermsState> emit,
  ) {
    if (state.searchCondidates.contains(event.newCondidate)) {
      emit(state.copyWith(searchCondidates: {...state.searchCondidates}..remove(event.newCondidate)));
    } else {
      emit(state.copyWith(searchCondidates: {...state.searchCondidates, event.newCondidate}));
    }
  }

  FutureOr<void> changeBusStatusCondidate(
    SetBusStatusCondidateEvent event,
    Emitter<FilterTermsState> emit,
  ) {
    if (state.busStatusCondidate.contains(event.newStatus)) {
      emit(state.copyWith(busStatusCondidate: {...state.busStatusCondidate}..remove(event.newStatus)));
    } else {
      emit(state.copyWith(busStatusCondidate: {...state.busStatusCondidate, event.newStatus}));
    }
  }

  FutureOr<void> changeDriverStatusCondidate(
    SetDriverStatusCondidateEvent event,
    Emitter<FilterTermsState> emit,
  ) {
    if (state.driverStatusCondidate.contains(event.newStatus)) {
      emit(state.copyWith(driverStatusCondidate: {...state.driverStatusCondidate}..remove(event.newStatus)));
    } else {
      emit(state.copyWith(driverStatusCondidate: {...state.driverStatusCondidate, event.newStatus}));
    }
  }

  FutureOr<void> changeDriverShiftCondidate(
    SetDriverShiftCondidateEvent event,
    Emitter<FilterTermsState> emit,
  ) {
    if (state.driverShiftCondidate.contains(event.newShift)) {
      emit(state.copyWith(driverShiftCondidate: {...state.driverShiftCondidate}..remove(event.newShift)));
    } else {
      emit(state.copyWith(driverShiftCondidate: {...state.driverShiftCondidate, event.newShift}));
    }
  }

  FutureOr<void> changeSecondDriverStatusCondidate(
    SetSecondDriverStatusCondidateEvent event,
    Emitter<FilterTermsState> emit,
  ) {
    if (state.secondDriverStatusCondidate.contains(event.newStatus)) {
      emit(
          state.copyWith(secondDriverStatusCondidate: {...state.secondDriverStatusCondidate}..remove(event.newStatus)));
    } else {
      emit(state.copyWith(secondDriverStatusCondidate: {...state.secondDriverStatusCondidate, event.newStatus}));
    }
  }

  FutureOr<void> changeSecondDriverShiftCondidate(
    SetSecondDriverShiftCondidateEvent event,
    Emitter<FilterTermsState> emit,
  ) {
    if (state.secondDriverShiftCondidate.contains(event.newShift)) {
      emit(state.copyWith(secondDriverShiftCondidate: {...state.secondDriverShiftCondidate}..remove(event.newShift)));
    } else {
      emit(state.copyWith(secondDriverShiftCondidate: {...state.secondDriverShiftCondidate, event.newShift}));
    }
  }
}