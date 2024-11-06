import 'dart:async';

import 'package:helper/helper.dart';
import 'package:kan_kan/integrations/supabase/supabase_client.dart';
import 'package:kan_kan/model/deal_model.dart';

mixin DealRepository {
  Future<List<DealModel>> getAllDeals() async {
    try {
      final List<Map<String, dynamic>> data = await KanSupabase.supabase.client
          .from('deals')
          .select(
              "*,categories(category_name) ,products(*,product_images(image_url))")
          .neq("deal_status", "private")
          .neq("deal_status", "closed")
          .neq("deal_status", "pending")
          .order("deal_status", ascending: true);
      return data.map((element) => DealModel.fromJson(element)).toList();

    } catch (e) {
      throw Exception('$e');
    }
  }

  Future<List<DealModel>> getDeals() async {
    try {
      final List<Map<String, dynamic>> data = await KanSupabase.supabase.client
          .from('deals')
          .select(
              "*,categories(category_name) ,products(*,product_images(image_url))")
          .neq("deal_status", "private")
          .neq("deal_status", "closed")
          .neq("deal_status", "pending")
          .gte("end_date",
              DateConverter.supabaseDateFormate(DateTime.now().toString()))
          .order("deal_status", ascending: true);
      return data.map((element) => DealModel.fromJson(element)).toList();
    } catch (e) {
      throw Exception('$e');
    }
  }

  getAllDealsAndCategoriess() async {
    await Future.delayed(Duration.zero);

    try {
      final List<Map<String, dynamic>> data = await KanSupabase.supabase.client
          .from('deals')
          .select(
              "*,categories(category_name) ,products(*,product_images(image_url))")
          .neq("deal_status", "private")
          .neq("deal_status", "closed")
          .neq("deal_status", "pending")
          .gte("end_date",
              DateConverter.supabaseDateFormate(DateTime.now().toString()))
          .order("start_date", ascending: true);

      return data.map((element) => DealModel.fromJson(element)).toList();
    } catch (e) {
      throw ("Error when get all Deals");
    }
  }

  getOneDealQuantity({required int dealID}) async {
    await Future.delayed(Duration.zero);

    try {
      final res = await KanSupabase.supabase.client
          .from("deals")
          .select("number_of_order")
          .eq("deal_id", dealID)
          .select();
      return res.first["number_of_order"];
    } catch (e) {
      throw (" $e خطأ");
    }
  }

  Future<DealModel> getOneDeal({required int dealID}) async {
    await Future.delayed(Duration.zero);

    try {
      final res = await KanSupabase.supabase.client
          .from("deals")
          .select(
              "*,categories(category_name) ,products(*,product_images(id,image_url))")
          .eq("deal_id", dealID);
      return DealModel.fromJson(res.first);
    } catch (e) {
      throw (" $e خطأ");
    }
  }
}
