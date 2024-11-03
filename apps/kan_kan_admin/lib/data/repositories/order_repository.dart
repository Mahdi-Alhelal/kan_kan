import 'package:kan_kan_admin/model/order_model.dart';

import '../../integrations/supabase/supabase_client.dart';

mixin OrderRepository {
  /*
  *
  * Tested
  * Update order
  *
  * */

  updateOrderStatus({
    required int id,
    required String status,
  }) async {
    try {
      await KanSupabase.supabase.client.from("orders").update({
        "order_status": status,
      }).eq("order_id", id);
      await KanSupabase.supabase.client
          .from("order_track")
          .insert({"order_id": id, "status": status});
      return true;
    } catch (e) {
      throw Exception('Error in update order: $e');
    }
  }

  updatePaymentStatus({required int orderId, required String status}) async {
    try {
      await KanSupabase.supabase.client
          .from("orders")
          .update({"payment_status": status}).eq("order_id", orderId);
      return true;
    } catch (e) {
      throw Exception('Error in update order: $e');
    }
  }

  updateAllOrdersStatus({
    required String status,
    required int dealId,
  }) async {
    try {
      await KanSupabase.supabase.client.from("orders").update({
        "order_status": status,
      }).eq("deal_id", dealId);

      return true;
    } catch (e) {
      throw Exception('Error in update order: $e');
    }
  }

  /*
  *
  * Tested
  * get all orders
  *
  * */
  Future<List<OrderModel>> getAllOrders() async {
    try {
      final List<Map<String, dynamic>> response =
          await KanSupabase.supabase.client.from("orders").select("*");
      return response.map((element) => OrderModel.fromJson(element)).toList();
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

  addToTracking({required List<int> ordersId, required String status}) async {
    try {
      List<Future> addAction = <Future>[];
      for (int id in ordersId) {
        addAction.add(KanSupabase.supabase.client
            .from("order_track")
            .insert({"order_id": id, "status": status}));
      }
      await Future.wait(addAction);
    } catch (e) {
      throw Exception('Error in add all orders to tracking: $e');
    }
  }
}

//for add order tracking
/*
 List<Future> futures = <Future>[];

       listOfId.map((orderId) =>
           futures.add(KanSupabase.supabase.client.from("orders").insert({
             "order_status": status,
           }).eq("order_id", orderId)));
       await Future.wait(futures);
 */