import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:kan_kan_admin/data/data_repository.dart';
import 'package:kan_kan_admin/integrations/supabase/supabase_client.dart';
import 'package:kan_kan_admin/layer/deal_data_layer.dart';
import 'package:kan_kan_admin/layer/order_data_layer.dart';
import 'package:kan_kan_admin/layer/product_data_layer.dart';
import 'package:kan_kan_admin/layer/user_layer.dart';
import 'package:kan_kan_admin/model/order_model.dart';
import 'package:kan_kan_admin/model/user_model.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
  OrderCubit() : super(OrderInitial()) {
    getNewOrder();
    getNewUser();
  }

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

  void getNewUser() {
    KanSupabase.supabase.client
        .channel('add_user')
        .onPostgresChanges(
            event: PostgresChangeEvent.insert,
            schema: 'public',
            table: 'users',
            callback: (newUser) {
              userOrderData.usersList
                  .add(UserModel.fromJson(newUser.newRecord));
              if (!isClosed) emit(SuccessOrderState());
            })
        .subscribe();
    if (!isClosed) emit(SuccessOrderState());
  }

  getNewOrder() {
    KanSupabase.supabase.client
        .channel('add_order')
        .onPostgresChanges(
            event: PostgresChangeEvent.insert,
            schema: 'public',
            table: 'orders',
            callback: (newData) {
              ordersData.orders.add(OrderModel.fromJson(newData.newRecord));
              if (!isClosed) emit(SuccessOrderState());
            })
        .subscribe();
  }
}
