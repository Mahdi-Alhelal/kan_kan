import 'package:get_it/get_it.dart';
import 'package:kan_kan_admin/data/repositories/oto_api.dart';
import 'package:kan_kan_admin/layer/order_data_layer.dart';
import 'package:kan_kan_admin/layer/user_layer.dart';
import 'package:kan_kan_admin/model/order_model.dart';
import 'package:kan_kan_admin/model/oto_model.dart';

import '../../integrations/supabase/supabase_client.dart';

mixin OrderRepository {
  /*
  *
  * Tested
  * Update order
  *
  * */

  updateOrderStatus({
    required int orderId,
    required String status,
  }) async {
    try {
      await KanSupabase.supabase.client.from("orders").update({
        "order_status": status,
      }).eq("order_id", orderId);
      await KanSupabase.supabase.client
          .from("order_track")
          .insert({"order_id": orderId, "status": status});
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
          await KanSupabase.supabase.client.from("orders").select("*").order("order_id",ascending: true);
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

  Future<void> addToTracking({required List<int> ordersId, required String status}) async {
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

  sendTrackingNumber(
      {required List<int> listOrdersId, required String dealName}) async {
    try {
      await OtoApi.getKey();

      List<Future> sendAction = <Future>[];
      for (int orderId in listOrdersId) {
        final order = GetIt.I
            .get<OrderDataLayer>()
            .orders
            .firstWhere((order) => order.orderId == orderId);
        final customer = GetIt.I
            .get<UserLayer>()
            .usersList
            .firstWhere((user) => user.userId == order.userId);
        final oto = OtoModel(
          orderId: orderId.toString(),
          amount: order.amount.toInt(),
          customer: Customer(
              name: customer.fullName,
              email: customer.email,
              mobile: customer.phone,
              address: order.address,
              city: order.address),
          item: Item(
              productId: order.dealId,
              name: dealName,
              price: (order.amount / order.quantity).toInt(),
              sku: "---",
              quantity: order.quantity),
        );

        sendAction.add(OtoApi.sendNotification(order: oto));
      }

      try {
        await Future.wait(sendAction);
      } catch (e) {
        throw Exception('Error in add all orders to tracking: $e');
      }

      return true;
    } catch (e) {
      throw Exception('Error in add all orders to tracking: $e');
    }
  }
}
