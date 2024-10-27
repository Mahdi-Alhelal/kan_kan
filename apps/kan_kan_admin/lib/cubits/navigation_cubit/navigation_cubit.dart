import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:kan_kan_admin/data/repositories/users_repository.dart';
import 'package:kan_kan_admin/layer/user_layer.dart';
import 'package:kan_kan_admin/model/models_2/user_model.dart';
import 'package:kan_kan_admin/screen/src/deals_screen.dart';
import 'package:kan_kan_admin/screen/src/factory_screen.dart';
import 'package:kan_kan_admin/screen/src/home_screen.dart';
import 'package:kan_kan_admin/screen/src/order_screen.dart';
import 'package:kan_kan_admin/screen/src/product_screen.dart';
import 'package:kan_kan_admin/screen/src/users_screen.dart';
import 'package:meta/meta.dart';

part 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  final userLayer = GetIt.I.get<UserLayer>();

  List<Widget> screens = const [
    HomeScreen(),
    UsersScreen(),
    FactoryScreen(),
    OrderScreen(),
    DealsScreen(),
    ProductScreen(),
  ];
  int index = 0;

  NavigationCubit() : super(NavigationInitial()) {
    getUsers();
  }

  navigationEvent({required int value}) {
    index = value;
    emit(NavigationToNewPage());
  }

  getUsers() async {
    await Future.delayed(Duration.zero);
    try {
      userLayer.usersList = await UsersRepository.getAllUsers();
      print(userLayer.usersList.length);
      emit(NavigationToNewPage());
    } catch (e) {
      print(e);
    }
  }
}
