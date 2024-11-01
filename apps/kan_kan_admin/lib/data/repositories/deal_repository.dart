import 'dart:developer';
import 'dart:io';

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

  Future<DealModel> addNewDeal(
      {required DealModel deal, required int productId}) async {
    try {
      final response = await KanSupabase.supabase.client
          .from("deals")
          .insert(deal.toJson(productId: productId))
          .select("*,categories(category_name) ,products(*,factories(*))");
      return DealModel.fromJson(response.first);
    } catch (e) {
      throw Exception('upload deal $e');
    }
  }

  Future<bool> updateDeal(
      {required DealModel deal, required int productId, dealId}) async {
    try {
      await KanSupabase.supabase.client
          .from("deals")
          .update(deal.toJson(productId: productId))
          .eq("deal_id", dealId);
      return true;
    } on PostgrestException {
      throw Exception('Error in get deal data');
    } catch (e) {
      throw Exception('$e');
    }
  }

  Future updateDealStatus(
      {required int dealId, required String dealStatus}) async {
    try {
      await KanSupabase.supabase.client
          .from('deals')
          .update({'deal_status': dealStatus}).eq('deal_id', dealId);
      return true;
    } on PostgrestException {
      throw Exception('Error in get deal data');
    } catch (e) {
      throw Exception('$e');
    }
  }

  uploadDealImage({required File image, required int dealId}) async {
    print("upload image in the list");
    //?-- change date formate
    String imageName = DateTime.now().toIso8601String();
    imageName = imageName.replaceAll("-", "_");
    imageName = imageName.replaceAll(".", "_");
    imageName = imageName.replaceAll(":", "_");
    //?-- check image type for insert
    final imageAsByte = await image.readAsBytes();
    try {
      //?--upload image to bucket
      await KanSupabase.supabase.client.storage.from("images").uploadBinary(
          imageName, imageAsByte,
          fileOptions: FileOptions(
              contentType: "image/${image.path.split(".").last}",
              upsert: true));
      //?-- upload image url to image table
      String imageUrl = KanSupabase.supabase.client.storage
          .from("images")
          .getPublicUrl(imageName);
      await KanSupabase.supabase.client
          .from("deal_images")
          .upsert({"image_url": imageUrl, "deal_id": dealId});
      return true;
    } catch (e) {
      throw Exception('Error: in upload this image to database: $e');
    }
  }
}
