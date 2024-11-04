import 'dart:async';
import 'dart:developer';

import 'package:kan_kan/integrations/supabase/supabase_client.dart';
import 'package:kan_kan/model/deal_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

mixin DealRepository {
  Future<List<DealModel>> getAllDeals() async {
    log("getAllDeals");
    try {
      final List<Map<String, dynamic>> data = await KanSupabase.supabase.client
          .from('deals')
          .select("*,categories(category_name) ,products(*)")
          .neq("deal_status", "private")
          .neq("deal_status", "closed")
          .neq("deal_status", "pending")
          .order("deal_id");
      return data.map((element) => DealModel.fromJson(element)).toList();
    } on PostgrestException {
      throw Exception('Error in get deal data');
    } catch (e) {
      throw Exception('$e');
    }
  }

  getAllDealsAndCategoriess() async {
    await Future.delayed(Duration.zero);
    log("getAllDealsAndCategories");

    try {
      final List<Map<String, dynamic>> data = await KanSupabase.supabase.client
          .from('deals')
          .select("*,categories(category_name) ,products(*)")
          .neq("deal_status", "private")
          .neq("deal_status", "closed")
          .neq("deal_status", "pending")
          .order("deal_id");
      return data.map((element) => DealModel.fromJson(element)).toList();
    } catch (e) {}
    // Create a StreamController to manage the combined stream

    // .onPostgresChanges(
    //     event: PostgresChangeEvent.all,
    //     schema: 'public',
    //     table: 'products',
    //     callback: (payload) {
    //       if (payload.newRecord.isNotEmpty) {
    //         final productsDealData = [payload.newRecord];
    //         final product = productsDealData
    //             .map((json) => DealModel.fromJson(json))
    //             .toList();
    //         streamController.add(product);
    //       }
    //     })
    // .onPostgresChanges(
    //     event: PostgresChangeEvent.all,
    //     schema: 'public',
    //     table: 'categories',
    //     callback: (payload) {
    //       if (payload.newRecord.isNotEmpty) {
    //         final categoryDealData = [payload.newRecord];
    //         final cat = categoryDealData
    //             .map((json) => DealModel.fromJson(json))
    //             .toList();
    //         streamController.add(cat);
    //       }
    //     })

    // // Remove subscriptions when no longer needed
    // streamController.onCancel = () {
    //   //KanSupabase.supabase.client.removeChannel(dealsSubscription);
    //   //KanSupabase.supabase.client.removeChannel(productsSubscription);
    //   // KanSupabase.supabase.client.removeChannel(categoriesSubscription);
    // };



 
  }



}
