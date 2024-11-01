import 'package:kan_kan_admin/model/order_model2.dart';

import '../../integrations/supabase/supabase_client.dart';

mixin OrderRepository {
  /*
  *
  * Tested
  * Add new Order
  *
  * */
  Future<List<Map<String, dynamic>>> addNewOrder(
      {required String userID,
      required String dealID,
      required String addressID,
      required double amount}) async {
    try {
      final dataFound = await KanSupabase.supabase.client
          .from("orders")
          .insert({
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

  updateOrderStatus({
    required int id,
    required String status,
  }) async {
    try {
      await KanSupabase.supabase.client.from("orders").update({
        "order_status": status,
      }).eq("order_id", id);
      return true;
    } catch (e) {
      throw Exception('Error in update order: $e');
    }
  }

  updateOrdersStatus({
    required String status,
    required int dealId,
  }) async {
    try {
      print('updateOrdersStatus api');

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