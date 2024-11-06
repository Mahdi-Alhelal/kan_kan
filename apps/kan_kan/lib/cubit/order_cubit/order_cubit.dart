import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:kan_kan/data/data_repository.dart';
import 'package:kan_kan/layer/deal_data_layer.dart';
import 'package:kan_kan/layer/order_data_layer.dart';
import 'package:kan_kan/layer/product_data_layer.dart';
import 'package:kan_kan/model/order_model.dart';
import 'package:meta/meta.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderInitial());

  final ordersData = GetIt.I.get<OrderDataLayer>();
  List oneOrderAllTracking = [];
  final userOrderDeal = GetIt.I.get<DealDataLayer>();
  final userOrderProduct = GetIt.I.get<ProductDataLayer>();

  getOneOrderUser({required int orderID}) async {
    emit(LoadingOrderState());

    try {
      ordersData.orders =
          await DataRepository().getOneOrdersByUser(orderID: orderID);

      return ordersData.orders.first;
    } catch (e) {
      throw Exception('Error in get all orders: $e');
    }
  }

  Stream<List<Map<String, dynamic>>>? getOneOrderAllTracking(
      {required int orderID}) {
    emit(LoadingOrderState());

    try {
      return DataRepository()
          .getAllTrackingForOneOrdersByUser(orderID: orderID);
    } catch (e) {
      return null;
    }
  }

  cancelOrder({required OrderModel order}) async {
    emit(LoadingOrderState());
    try {
      await DataRepository().cancelOrder(order: order);
      emit(SuccesCanceledOrderState());
    } catch (e) {
      return null;
    }
  }
}
