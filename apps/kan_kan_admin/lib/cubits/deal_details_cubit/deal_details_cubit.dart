import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:kan_kan_admin/layer/order_data_layer.dart';
import 'package:kan_kan_admin/layer/user_layer.dart';
import 'package:kan_kan_admin/model/order_model2.dart';
import 'package:meta/meta.dart';

part 'deal_details_state.dart';

class DealDetailsCubit extends Cubit<DealDetailsState> {
  DealDetailsCubit() : super(DealDetailsInitial());
  //?-- data layer
  final orderLayer = GetIt.I.get<OrderDataLayer>();
  final userLayer = GetIt.I.get<UserLayer>();
  List<OrderModel> currentOrders = [];
  dealOrders({required int dealId}) {
    currentOrders = orderLayer.orders
        .where((OrderModel order) => order.dealId == dealId)
        .toList();
  }
}
