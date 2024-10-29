import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:kan_kan_admin/data/data_repository.dart';
import 'package:kan_kan_admin/layer/deal_data_layer.dart';
import 'package:kan_kan_admin/layer/order_data_layer.dart';
import 'package:kan_kan_admin/layer/product_data_layer.dart';
import 'package:kan_kan_admin/layer/user_layer.dart';
import 'package:meta/meta.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  final ordersData = GetIt.I.get<OrderDataLayer>();
  final userOrderData = GetIt.I.get<UserLayer>();
  final userOrderDeal = GetIt.I.get<DealDataLayer>();
  final userOrderProduct = GetIt.I.get<ProductDataLayer>();

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
}
