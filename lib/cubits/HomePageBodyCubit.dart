import 'package:bus_information/Constants.dart';
import 'package:bus_information/abstracts/Observer.dart';
import 'package:bus_information/models/events.dart';
import 'package:bus_information/models/objects/Bus.dart';
import 'package:bus_information/models/objects/Driver.dart';
import 'package:bus_information/repository/database/DatabaseHelper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePageBodyCubit extends Cubit<HomePageBodyState> implements Observer {
  HomePageBodyCubit(HomePageBodyState initialState) : super(initialState);
  DatabaseHelper databaseHelper = DatabaseHelper.instance;

  List<Driver> get drivers => databaseHelper.drivers;

  List<Bus> get buses => databaseHelper.buses;

  @override
  String get key => Constants.homePageBodyCubitKey;

  @override
  onNewEvent(Data? data) {
    emit(HomePageBodyData());
  }



}

abstract class HomePageBodyState {}

class HomePageBodyLoading extends HomePageBodyState {}

class HomePageBodyData extends HomePageBodyState {}
class HomePageBodyBuses extends HomePageBodyData {}
class HomePageBodyDrivers extends HomePageBodyData {}
