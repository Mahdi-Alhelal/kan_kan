import 'package:bloc/bloc.dart';
import 'package:kan_kan/data/data_repository.dart';
import 'package:kan_kan/model/order_model.dart';
import 'package:meta/meta.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit() : super(PaymentInitial());

  addPaymentEvent(
      {required String userID,
      required String paymentMethod,
      required String paymentStatus,
      required String transactionID,
      required String address,
      required int dealID,
      required int quantity,
      required int allQuantity,
      required double amount}) async {
    emit(LoadingPaymentState());
    try {
      final response = await DataRepository().addNewPayment(
          userID: userID,
          paymentMethod: paymentMethod,
          paymentStatus: paymentStatus,
          transactionID: transactionID,
          amount: amount);
      print(response.toString());
      final responseOrder = await DataRepository().addNewOrder(
          userID: userID, dealID: dealID, address: address, amount: amount,quantity :quantity,allQuantity: allQuantity);
      emit(SuccessPaymentState());

      return responseOrder;
    } catch (e) {
      print(e);
    }
  }
}
