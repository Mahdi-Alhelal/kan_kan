import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:kan_kan_admin/data/data_repository.dart';
import 'package:kan_kan_admin/layer/deal_data_layer.dart';
import 'package:kan_kan_admin/layer/order_data_layer.dart';
import 'package:kan_kan_admin/layer/product_data_layer.dart';
import 'package:kan_kan_admin/layer/user_layer.dart';
import 'package:meta/meta.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  //?-- data layer
  final ordersData = GetIt.I.get<OrderDataLayer>();
  final userOrderData = GetIt.I.get<UserLayer>();
  final userOrderDeal = GetIt.I.get<DealDataLayer>();
  final userOrderProduct = GetIt.I.get<ProductDataLayer>();

  //?-- table sorting
  bool sort = true;
  int columnIndex = 0;

  //?-- filters
  List<bool> selected = [true, false, false, false, false, false, false, false];

  OrderCubit() : super(OrderInitial());

  getAllOrdersEvent() async {
    emit(LoadingOrderState());
    print("here Order");
    try {
      ordersData.orders = await DataRepository().getAllOrders();
      emit(SuccessOrderState());
    } catch (e) {
      print(e);
    }
  }

  onToggleEvent(int value) {
    int index = selected.indexOf(true);
    selected[index] = false;
    selected[value] = true;
    emit(SuccessOrderState());
  }

  void sortEvent() {
    emit(SortSuccessState());
  }
}
