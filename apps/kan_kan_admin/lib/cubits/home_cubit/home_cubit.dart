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

  HomeCubit() : super(HomeInitial()) {
    getNewOrder();
    getNewUser();
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
