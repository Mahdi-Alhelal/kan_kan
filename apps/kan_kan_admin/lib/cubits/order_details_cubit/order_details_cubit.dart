import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:kan_kan_admin/data/data_repository.dart';
import 'package:kan_kan_admin/layer/deal_data_layer.dart';
import 'package:kan_kan_admin/layer/order_data_layer.dart';
import 'package:meta/meta.dart';

part 'order_details_state.dart';

class OrderDetailsCubit extends Cubit<OrderDetailsState> {
  final api = DataRepository();

  final ordersData = GetIt.I.get<OrderDataLayer>();
  final dealLayer = GetIt.I.get<DealDataLayer>();

  OrderDetailsCubit() : super(OrderDetailsInitial());

  updateUserOrderStatus({required int id}) async {
    try {
      int index =
          ordersData.orders.indexWhere((element) => element.orderId == id);
      final response = await api.updateOrderStatus(
          orderId: ordersData.orders[index].orderId, status: "canceled");
      if (response) {
        ordersData.orders[index].orderStatus = "canceled";
        int dealIndex = dealLayer.deals.indexWhere(
            (deal) => ordersData.orders[index].dealId == deal.dealId);
        dealLayer.deals[dealIndex].numberOfOrder =
            dealLayer.deals[dealIndex].numberOfOrder -
                ordersData.orders[index].quantity;
        await api.updateDealNumberOfOrder(
            dealId: ordersData.orders[index].dealId,
            numberOfOrder: dealLayer.deals[dealIndex].numberOfOrder.toInt());
      }

      if (!isClosed) emit(SuccessState());
    } catch (errorMessage) {
      print(errorMessage);
      if (!isClosed) {
        emit(ErrorState(errorMessage: errorMessage.toString()));
      }
    }
  }
}
