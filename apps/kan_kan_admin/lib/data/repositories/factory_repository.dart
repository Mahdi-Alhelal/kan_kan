import 'package:kan_kan_admin/model/factory_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../integrations/supabase/supabase_client.dart';

mixin FactoryRepository {
  /*
  *
  * Tested
  * Add new Factory
  *
  * */
  Future<FactoryModel> addNewFactory({required FactoryModel factory}) async {
    try {
      final response = await KanSupabase.supabase.client
          .from("factories")
          .upsert(factory.toJson())
          .select();
      return FactoryModel.fromJson(response.first);
    } on PostgrestException {
      throw Exception('Error in add new factory');
    } catch (e) {
      throw Exception('invalid factory data');
    }
  }

  /*
  *
  * Tested
  * Update Factory
  *
  * */

  updateFactory({required FactoryModel factory}) async {
    try {
      await KanSupabase.supabase.client
          .from("factories")
          .update(factory.toJson())
          .eq("factory_id", factory.factoryId);
      return true;
    } on PostgrestException {
      throw Exception('Error in update factory');
    } catch (e) {
      throw Exception('Error in update factory: $e');
    }
  }

  /*
  *
  * Tested
  * get all factories
  *
  * */
  Future<List<FactoryModel>> getAllFactories() async {
    try {
      final response = await KanSupabase.supabase.client
          .from("factories")
          .select("*")
          .order("factory_id", ascending: true);

      return response.map((element) => FactoryModel.fromJson(element)).toList();
    } on PostgrestException {
      throw Exception('Error in get factories data');
    } catch (e) {
      throw Exception('Error in get  factories data: $e');
    }
  }

  Future updateFactoryStatus({required bool status, required int id}) async {
    try {
      await KanSupabase.supabase.client
          .from("factories")
          .update({"is_black_list": status}).eq("factory_id", id);
      return true;
    } on PostgrestException {
      throw Exception('Error in get factories data');
    } catch (e) {
      throw Exception('Error in get  factories data: $e');
    }
  }
}
