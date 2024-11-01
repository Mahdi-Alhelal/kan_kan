import 'package:kan_kan/integrations/supabase/supabase_client.dart';
import 'package:kan_kan/model/order_model.dart';

mixin OrderRepository {
  // Supabase client instance
  // final SupabaseClient _supabase = SupabaseService().client;

  /*
  *
  * Tested
  * Add new Order
  *
  * */
  Future<OrderModel> addNewOrder(
      {required String userID,
      required int dealID,
      required String address,
      required int quantity,
      required double amount}) async {
    try {
      final dataFound =
          await KanSupabase.supabase.client.from("orders").insert({
        "deal_id": dealID,
        "user_id": userID,
        "address": address,
        "amount": amount,
        "quantity": quantity
      }).select();

      return OrderModel.fromJson(dataFound.first);
      ;
    } catch (e) {
      throw Exception('Error in add order: $e');
    }
  }

  /*
  *
  * Tested
  * Update order
  *
  * */

  updateOrder({
    required String id,
    required String status,
  }) async {
    try {
      final dataFound = await KanSupabase.supabase.client
          .from("orders")
          .select("*")
          .match({"order_id": id}).select();
      if (dataFound.isNotEmpty) {
        await KanSupabase.supabase.client.from("orders").update({
          "order_status": status,
        }).eq("order_id", id);
      }
    } catch (e) {
      throw Exception('Error in update order: $e');
    }
  }

  /*
  *
  * Tested
  * get all orders for one user
  *
  * */
  Future<List<OrderModel>> getAllOrdersByUser({required String userID}) async {
    try {
      final List<Map<String, dynamic>> response = await KanSupabase
          .supabase.client
          .from("orders")
          .select("*")
          .eq("user_id", userID);
      return response.map((element) => OrderModel.fromJson(element)).toList();
    } catch (e) {
      throw Exception('Error in get all orders: $e');
    }
  }
}
