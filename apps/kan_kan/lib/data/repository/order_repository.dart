import 'package:get_it/get_it.dart';
import 'package:kan_kan/data/data_repository.dart';
import 'package:kan_kan/integrations/supabase/supabase_client.dart';
import 'package:kan_kan/layer/user_data_layer.dart';
import 'package:kan_kan/model/order_model.dart';

mixin OrderRepository {


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
      
    } catch (e) {
      throw Exception('Error in add order: $e');
    }
  }


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

  cancelOrder({required OrderModel order}) async {
    try {
      final dataFound = await KanSupabase.supabase.client
          .from("orders")
          .select("*")
          .match({"order_id": order.orderId}).select();
      if (dataFound.isNotEmpty) {
        await KanSupabase.supabase.client.from("orders").update({
          "order_status": "canceled",
        }).eq("order_id", order.orderId);
        int allQnt =
            await DataRepository().getOneDealQuantity(dealID: order.dealId);
        allQnt -= order.quantity;
        await KanSupabase.supabase.client
            .from("deals")
            .update({"number_of_order": allQnt}).eq("deal_id", order.dealId);
        await KanSupabase.supabase.client
            .from("order_track")
            .insert({"order_id": order.dealId, "status": "canceled"});
        double oldBalance = GetIt.I.get<UserDataLayer>().user.balance;
        double newBalance = oldBalance + order.amount;

        await KanSupabase.supabase.client
            .from("users")
            .update({"balance": newBalance}).eq("user_id", order.userId);
      }
    } catch (e) {
      throw Exception('Error in update order: $e');
    }
  }


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
