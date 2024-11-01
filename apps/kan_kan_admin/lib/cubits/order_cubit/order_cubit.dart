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

  final api = DataRepository();
  //?-- table sorting
  bool sort = true;
  int columnIndex = 0;

  //?-- filters
  List<bool> selected = [true, false, false, false, false, false, false, false];

  //?-- tmp status;
  String tmpUserOrderStatus = '';
  OrderCubit() : super(OrderInitial());

  getAllOrdersEvent() async {
    if (!isClosed) emit(LoadingOrderState());
    try {
      ordersData.orders = await api.getAllOrders();
      if (!isClosed) emit(SuccessOrderState());
    } catch (errorMessage) {
      if (!isClosed) {
        emit(ErrorOrderState(errorMessage: errorMessage.toString()));
      }
    }
  }

  onToggleEvent(int value) {
    int index = selected.indexOf(true);
    selected[index] = false;
    selected[value] = true;
    if (!isClosed) emit(SuccessOrderState());
  }

  void sortEvent() {
    if (!isClosed) emit(SortSuccessState());
  }

  updateUserOrderStatus({required int index}) async {
    try {
      final response = await api.updateOrderStatus(
          id: ordersData.orders[index].orderId, status: tmpUserOrderStatus);
      if (response) {
        ordersData.orders[index].orderStatus = tmpUserOrderStatus;
      }
      if (!isClosed) emit(SuccessOrderState());
    } catch (errorMessage) {
      print(errorMessage);
      if (!isClosed) {
        emit(ErrorOrderState(errorMessage: errorMessage.toString()));
      }
    }
  }
}
