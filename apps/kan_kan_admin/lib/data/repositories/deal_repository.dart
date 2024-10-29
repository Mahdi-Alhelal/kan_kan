import 'dart:developer';

import 'package:kan_kan_admin/integrations/supabase/supabase_client.dart';
import 'package:kan_kan_admin/model/deal_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

mixin DealRepository {
  Future<List<DealModel>> getAllDeals() async {
    log("getAllDeals");
    try {
      final List<Map<String, dynamic>> data = await KanSupabase.supabase.client
          .from('deals')
          .select("*,categories(category_name) ,products(*,factories(*))");
      return data.map((element) => DealModel.fromJson(element)).toList();
    } on PostgrestException {
      throw Exception('Error in get deal data');
    } catch (e) {
      throw Exception('$e');
    }
  }

//Todo testing insertDeal
  Future<bool> addNewDeal(
      {required DealModel deal, required int productId}) async {
    try {
      await KanSupabase.supabase.client
          .from("deals")
          .insert(deal.toJson(productId: productId));
      return true;
    } catch (e) {
      throw Exception('$e');
    }
  }

  //Todo testing updateDeal
  Future updateDeal(
      {required DealModel deal, required int productId, dealId}) async {
    log("insertDeal");
    try {
      await KanSupabase.supabase.client
          .from("deals")
          .update(deal.toJson(productId: productId))
          .eq("deal_id", dealId);
    } on PostgrestException {
      throw Exception('Error in get deal data');
    } catch (e) {
      throw Exception('$e');
    }
  }
}
