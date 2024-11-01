import 'package:kan_kan/integrations/supabase/supabase_client.dart';

mixin PaymentRepository {
  /*
  *
  * NOT TESTED YET !!!!!!!
  * Add new Payment
  *
  * */
  addNewPayment(
      {required String userID,
      required String paymentMethod,
      required String paymentStatus,
      required String transactionID,
      required double amount}) async {
    try {
      final response =
          await KanSupabase.supabase.client.from("payments").insert({
        "user_id": userID,
        "payment_amount": amount,
        "payment_status": paymentStatus,
        "transaction_id": transactionID,
      }).select();
      return response.first["payment_id"].toString();
    } catch (e) {
      throw Exception('Error in add payment: $e');
    }
  }
}
