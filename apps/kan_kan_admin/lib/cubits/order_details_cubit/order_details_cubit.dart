import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:kan_kan_admin/data/data_repository.dart';
import 'package:kan_kan_admin/layer/order_data_layer.dart';
import 'package:meta/meta.dart';

part 'order_details_state.dart';

class OrderDetailsCubit extends Cubit<OrderDetailsState> {
  final api = DataRepository();

  final ordersData = GetIt.I.get<OrderDataLayer>();

  OrderDetailsCubit() : super(OrderDetailsInitial());

  updateUserOrderStatus({required int id}) async {
    try {
      int index =
          ordersData.orders.indexWhere((element) => element.orderId == id);
      final response = await api.updateOrderStatus(
          id: ordersData.orders[index].orderId, status: "canceled");
      if (response) {
        ordersData.orders[index].orderStatus = "canceled";
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
