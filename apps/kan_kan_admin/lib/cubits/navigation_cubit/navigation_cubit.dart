import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:kan_kan_admin/screen/src/deals_screen.dart';
import 'package:kan_kan_admin/screen/src/factory_screen.dart';
import 'package:kan_kan_admin/screen/src/home_screen.dart';
import 'package:kan_kan_admin/screen/src/order_screen.dart';
import 'package:kan_kan_admin/screen/src/product_screen.dart';
import 'package:kan_kan_admin/screen/src/users_screen.dart';
import 'package:meta/meta.dart';

part 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  List<Widget> screens = const [
    HomeScreen(),
    UsersScreen(),
    FactoryScreen(),
    OrderScreen(),
    DealsScreen(),
    ProductScreen(),
  ];
  int index = 0;

  NavigationCubit() : super(NavigationInitial());

  navigationEvent({required int value}) {
    index = value;
    emit(NavigationToNewPage());
  }
}
