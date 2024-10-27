import 'dart:developer';

import 'package:kan_kan_admin/integrations/supabase/supabase_client.dart';
import 'package:kan_kan_admin/model/models_2/deal_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

mixin DealRepository {
  static Future<List<DealModel>> getAllDeals() async {
    log("getAllDeals");
    try {
      final List<Map<String, dynamic>> data = await KanSupabase.supabase.client
          .from('deals')
          .select("*,categories(category_name) ,products(*,factories(*))");
      return data.map((element)=>DealModel.fromJson(element)).toList();
    } on PostgrestException {
      throw Exception('Error in get deal data');
    } catch (e) {
      throw Exception('$e');
    }
  }

//Todo testing insertDeal
  static Future<bool> insertDeal() async {
    log("insertDeal");
    try {
      // KanSupabase.supabase.client.from("deals").insert();
      return true;
    } on PostgrestException {
      throw Exception('Error in get deal data');
    } catch (e) {
      throw Exception('$e');
    }
  }

  //Todo testing updateDeal
  static Future<bool> updateDeal() async {
    log("insertDeal");
    try {
      //  KanSupabase.supabase.client.from("deals").update("values").eq("deal_id", "value");
      return true;
    } on PostgrestException {
      throw Exception('Error in get deal data');
    } catch (e) {
      throw Exception('$e');
    }
  }
}
