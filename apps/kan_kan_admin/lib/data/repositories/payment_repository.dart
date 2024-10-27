
import 'package:kan_kan_admin/integrations/supabase/supabase_client.dart';

class PaymentRepository {
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
      required int orderID,
      required String transactionID,
      required double amount}) async {
    try {
      await KanSupabase.supabase.client.from("payments").insert({
        "order_id": orderID,
        "created_by": userID,
        "payment_amount": amount,
        "payment_status": paymentStatus,
        "transaction_id": transactionID,
      }).select();
    } catch (e) {
      throw Exception('Error in update factory: $e');
    }
  }
}
