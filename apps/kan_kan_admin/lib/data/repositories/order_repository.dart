import '../../integrations/supabase/supabase_client.dart';

class OrderRepository {
  // Supabase client instance
  // final SupabaseClient _supabase = SupabaseService().client;

  /*
  *
  * Tested
  * Add new Order
  *
  * */
  static Future<List<Map<String, dynamic>>> addNewOrder(
      {required String userID,
      required String dealID,
      required String addressID,
      required double amount}) async {
    try {
      final dataFound = await supabase.client.from("orders").insert({
        "deal_id": dealID,
        "user_id": userID,
        "address_id": addressID,
        "amount": amount
      }).select(); // here we need to check if i can to deplicated or not
      return dataFound;
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

  static updateOrder({
    required String id,
    required String status,
  }) async {
    try {
      final dataFound = await supabase.client
          .from("orders")
          .select("*")
          .match({"order_id": id}).select();
      if (dataFound.isNotEmpty) {
        await supabase.client.from("orders").update({
          "order_status": status,
        }).eq("order_id", id);
      }
    } catch (e) {
      throw Exception('Error in update order: $e');
    }
  }

  static updateAllOrdersForOneDeal(
      {required String status, required String dealID}) async {
    try {
      final dataFound = await supabase.client
          .from("orders")
          .select("*")
          .match({"deal_id": dealID}).select();
      if (dataFound.isNotEmpty) {
        await supabase.client.from("orders").update({
          "order_status": status,
        }).eq("deal_id", dealID);
      }
    } catch (e) {
      throw Exception('Error in update all orders for one deal: $e');
    }
  }

  /*
  *
  * Tested
  * get all orders
  *
  * */
  static Future<List<Map<String, dynamic>>> getAllOrders() async {
    try {
      final response = await supabase.client.from("orders").select("*");
      return response;
    } catch (e) {
      throw Exception('Error in get all orders: $e');
    }
  }

  /*
  *
  * Tested
  * get all orders for one user
  *
  * */
  static Future<List<Map<String, dynamic>>> getAllOrdersByUser(
      {required String userID}) async {
    try {
      final response = await supabase.client
          .from("orders")
          .select("*")
          .eq("user_id", userID);
      return response;
    } catch (e) {
      throw Exception('Error in get all orders: $e');
    }
  }
}
