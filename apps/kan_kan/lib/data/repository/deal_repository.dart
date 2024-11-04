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
          .order("start_date");
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
          .order("start_date", ascending: true);
      return data.map((element) => DealModel.fromJson(element)).toList();
    } catch (e) {
      throw ("Error when get all Deals");
    }
  }
}
