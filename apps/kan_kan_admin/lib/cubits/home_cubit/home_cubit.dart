import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:kan_kan_admin/integrations/supabase/supabase_client.dart';
import 'package:kan_kan_admin/layer/deal_data_layer.dart';
import 'package:kan_kan_admin/layer/factory_data_layer.dart';
import 'package:kan_kan_admin/layer/order_data_layer.dart';
import 'package:kan_kan_admin/layer/product_data_layer.dart';
import 'package:kan_kan_admin/layer/user_layer.dart';
import 'package:kan_kan_admin/model/order_model2.dart';
import 'package:kan_kan_admin/model/user_model.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  int touchedIndex = -1;
  final dealLayer = GetIt.I.get<DealDataLayer>();
  final productLayer = GetIt.I.get<ProductDataLayer>();
  final factoryLayer = GetIt.I.get<FactoryDataLayer>();
  final userLayer = GetIt.I.get<UserLayer>();
  final orderLayer = GetIt.I.get<OrderDataLayer>();
  num pendingNum = 0;
  num processingNum = 0;
  num inChinaNum = 0;
  num inTransitNum = 0;
  num inSaudiNum = 0;
  num withShipmentCompanyNum = 0;
  num completedNum = 0;
  num canceledNum = 0;
  num total = 0;
  List<OrderModel> monthOrders = [];

  //?-- table sorting
  bool sort = true;
  int columnIndex = 0;

  HomeCubit() : super(HomeInitial()) {
    getNewOrder();
    getNewUser();
    monthOrders = orderLayer.orders
        .where((order) =>
            DateTime.parse(order.orderDate).month == DateTime.now().month)
        .toList();
    pendingNum = monthOrders
        .where((order) => order.orderStatus == "pending")
        .toList()
        .length;

    processingNum = monthOrders
        .where((order) => order.orderStatus == "processing")
        .toList()
        .length;

    inChinaNum = monthOrders
        .where((order) => order.orderStatus == "inChina")
        .toList()
        .length;

    inTransitNum = monthOrders
        .where((order) => order.orderStatus == "inTransit")
        .toList()
        .length;

    inSaudiNum = monthOrders
        .where((order) => order.orderStatus == "inSaudi")
        .toList()
        .length;

    withShipmentCompanyNum = monthOrders
        .where((order) => order.orderStatus == "withShipmentCompany")
        .toList()
        .length;

    completedNum = monthOrders
        .where((order) => order.orderStatus == "completed")
        .toList()
        .length;

    canceledNum = monthOrders
        .where((order) => order.orderStatus == "canceled")
        .toList()
        .length;
    total = pendingNum +
        processingNum +
        inChinaNum +
        inTransitNum +
        inSaudiNum +
        withShipmentCompanyNum +
        completedNum +
        canceledNum;
  }

  update() {
    emit(UpdateState());
  }

  void getNewUser() {
    KanSupabase.supabase.client
        .channel('add_user')
        .onPostgresChanges(
            event: PostgresChangeEvent.insert,
            schema: 'public',
            table: 'users',
            callback: (newUser) {
              userLayer.usersList.add(UserModel.fromJson(newUser.newRecord));
              if (!isClosed) emit(UpdateState());
            })
        .subscribe();
  }

  void getNewOrder() {
    KanSupabase.supabase.client
        .channel('add_order')
        .onPostgresChanges(
            event: PostgresChangeEvent.insert,
            schema: 'public',
            table: 'orders',
            callback: (newData) {
              orderLayer.orders.add(OrderModel.fromJson(newData.newRecord));
              if (!isClosed) emit(UpdateState());
            })
        .subscribe();
  }
}
