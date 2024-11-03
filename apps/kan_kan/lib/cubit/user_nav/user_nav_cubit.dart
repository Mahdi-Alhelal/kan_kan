import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:kan_kan/layer/user_data_layer.dart';
import 'package:kan_kan/screens/home/deals_screen.dart';
import 'package:kan_kan/screens/home/home_screen.dart';
import 'package:kan_kan/screens/home/profile_screen.dart';
import 'package:meta/meta.dart';

part 'user_nav_state.dart';

class UserNavCubit extends Cubit<UserNavState> {
  final userLayer = GetIt.I.get<UserDataLayer>();

  List<Widget> screens = [HomeScreen(), DealsScreen(), ProfileScreen()];

  int index = 0;
  UserNavCubit() : super(UserNavInitial());

   updateEvent() {
    if (!isClosed) emit(SuccessNavState());
  }
}
