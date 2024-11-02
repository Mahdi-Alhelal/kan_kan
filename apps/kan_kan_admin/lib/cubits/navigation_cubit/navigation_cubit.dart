import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:kan_kan_admin/data/data_repository.dart';
import 'package:kan_kan_admin/integrations/supabase/supabase_client.dart';
import 'package:kan_kan_admin/layer/category_data_layer.dart';
import 'package:kan_kan_admin/layer/deal_data_layer.dart';
import 'package:kan_kan_admin/layer/factory_data_layer.dart';
import 'package:kan_kan_admin/layer/order_data_layer.dart';
import 'package:kan_kan_admin/layer/product_data_layer.dart';
import 'package:kan_kan_admin/layer/user_layer.dart';
import 'package:kan_kan_admin/model/order_model2.dart';
import 'package:kan_kan_admin/model/user_model.dart';
import 'package:kan_kan_admin/screen/src/deals_screen.dart';
import 'package:kan_kan_admin/screen/src/factory_screen.dart';
import 'package:kan_kan_admin/screen/src/home_screen.dart';
import 'package:kan_kan_admin/screen/src/order_screen.dart';
import 'package:kan_kan_admin/screen/src/product_screen.dart';
import 'package:kan_kan_admin/screen/src/users_screen.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  final userLayer = GetIt.I.get<UserLayer>();
  final productLayer = GetIt.I.get<ProductDataLayer>();
  final factoryLayer = GetIt.I.get<FactoryDataLayer>();
  final dealLayer = GetIt.I.get<DealDataLayer>();
  final orderLayer = GetIt.I.get<OrderDataLayer>();
  final categoryLayer = GetIt.I.get<CategoryDataLayer>();

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
    getProductData();
    getFactoryData();
    getDealData();
    getOrderData();
    getCategories();
    addNewOrder();
    addNewUser();
  }

  navigationEvent({required int value}) {
    index = value;
    if (!isClosed) emit(NavigationToNewPage());
  }

  getProductData() async {
    await Future.delayed(Duration.zero);
    try {
      productLayer.products = await api.getAllProducts();
      if (!isClosed) emit(SuccessState());
    } catch (errorMessage) {
      if (!isClosed) emit(ErrorState(errorMessage: errorMessage.toString()));
    }
  }

  getDealData() async {
    await Future.delayed(Duration.zero);
    try {
      dealLayer.deals = await api.getAllDeals();
      if (!isClosed) emit(SuccessState());
    } catch (errorMessage) {
      if (!isClosed) emit(ErrorState(errorMessage: errorMessage.toString()));
    }
  }

  getOrderData() async {
    await Future.delayed(Duration.zero);
    try {
      orderLayer.orders = await api.getAllOrders();
      if (!isClosed) emit(SuccessState());
    } catch (errorMessage) {
      if (!isClosed) emit(ErrorState(errorMessage: errorMessage.toString()));
    }
  }

  getFactoryData() async {
    await Future.delayed(Duration.zero);
    try {
      factoryLayer.factories = await api.getAllFactories();
      if (!isClosed) emit(SuccessState());
    } catch (errorMessage) {
      if (!isClosed) emit(ErrorState(errorMessage: errorMessage.toString()));
    }
  }

  getUsers() async {
    await Future.delayed(Duration.zero);
    try {
      userLayer.usersList = await api.getAllUsers();
      if (!isClosed) emit(NavigationToNewPage());
    } catch (errorMessage) {
      if (!isClosed) emit(ErrorState(errorMessage: errorMessage.toString()));
    }
  }

  getCategories() async {
    await Future.delayed(Duration.zero);
    try {
      categoryLayer.categories = await api.getAllCategories();
      if (!isClosed) emit(NavigationToNewPage());
    } catch (errorMessage) {
      if (!isClosed) emit(ErrorState(errorMessage: errorMessage.toString()));
    }
  }

  addNewUser() {
    KanSupabase.supabase.client
        .channel('add_user')
        .onPostgresChanges(
            event: PostgresChangeEvent.insert,
            schema: 'public',
            table: 'users',
            callback: (newUser) {
              userLayer.usersList.add(UserModel.fromJson(newUser.newRecord));
              if (!isClosed) emit(SuccessState());
            })
        .subscribe();
    if (!isClosed) emit(SuccessState());
  }

  addNewOrder() {
    KanSupabase.supabase.client
        .channel('add_order')
        .onPostgresChanges(
            event: PostgresChangeEvent.insert,
            schema: 'public',
            table: 'orders',
            callback: (newData) {
              orderLayer.orders.add(OrderModel.fromJson(newData.newRecord));
              if (!isClosed) emit(SuccessState());
            })
        .subscribe();
    if (!isClosed) emit(SuccessState());
  }
}
