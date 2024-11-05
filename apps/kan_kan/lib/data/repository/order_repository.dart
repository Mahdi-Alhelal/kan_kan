import 'package:kan_kan/data/data_repository.dart';
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
      required int allQuantity,
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
      allQuantity += quantity;

      await KanSupabase.supabase.client
          .from("deals")
          .update({"number_of_order": allQuantity})
          .eq("deal_id", dealID)
          .select();
      final jsonOrderToModel = OrderModel.fromJson(dataFound.first);
      await KanSupabase.supabase.client.from("order_track").insert(
          {"order_id": jsonOrderToModel.orderId, "status": "pending"}).select();

      return jsonOrderToModel;
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
    required int id,
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

  cancelOrder(
      {required int id, required int dealID, required int quantity}) async {
    try {
      final dataFound = await KanSupabase.supabase.client
          .from("orders")
          .select("*")
          .match({"order_id": id}).select();
      if (dataFound.isNotEmpty) {
        await KanSupabase.supabase.client.from("orders").update({
          "order_status": "canceled",
        }).eq("order_id", id);
        int allQnt = await DataRepository().getOneDealQuantity(dealID: dealID);
        allQnt -= quantity;
        await KanSupabase.supabase.client
            .from("deals")
            .update({"number_of_order": allQnt}).eq("deal_id", dealID);
        await KanSupabase.supabase.client
            .from("order_track")
            .insert({"order_id": id, "status": "canceled"});
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
          .eq("user_id", userID)
          .order("order_id");
      return response.map((element) => OrderModel.fromJson(element)).toList();
    } catch (e) {
      throw Exception('Error in get all orders: $e');
    }
  }

  Future<List<OrderModel>> getOneOrdersByUser({required int orderID}) async {
    try {
      final response = await KanSupabase.supabase.client
          .from("orders")
          .select("*")
          .eq("order_id", orderID);
      return response.map((element) => OrderModel.fromJson(element)).toList();
    } catch (e) {
      throw Exception('Error in get all orders: $e');
    }
  }

  Stream<List<Map<String, dynamic>>> getAllTrackingForOneOrdersByUser(
      {required int orderID}) {
    try {
      final response = KanSupabase.supabase.client
          .from("order_track")
          .stream(primaryKey: ["id"])
          .eq("order_id", orderID)
          .order("created_at");
      return response;
    } catch (e) {
      throw Exception('Error in get all order tracking: $e');
    }
  }
}
