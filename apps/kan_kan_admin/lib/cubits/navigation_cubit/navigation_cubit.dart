import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:kan_kan_admin/data/data_repository.dart';
import 'package:kan_kan_admin/data/repositories/users_repository.dart';
import 'package:kan_kan_admin/layer/product_data_layer.dart';
import 'package:kan_kan_admin/layer/user_layer.dart';
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
  final productLayer = GetIt.I.get<ProductDataLayer>();
  final api = DataRepository();
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

  getProductData() async {
    await Future.delayed(Duration.zero);
    try {
      productLayer.products =await api.getAllProducts();
    } catch (errorMessage) {
      emit(ErrorState(errorMessage: errorMessage.toString()));
    }
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
