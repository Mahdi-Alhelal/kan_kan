import 'dart:developer';

import 'package:kan_kan_admin/integrations/supabase/supabase_client.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DealRepository {
  static Future getAllDeals() async {
    log("getAllDeals");
    try {
      final data = await KanSupabase.supabase.client
          .from('deals')
          .select("*,products(*,factories(*))");
      return data;
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
