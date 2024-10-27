import '../../integrations/supabase/supabase_client.dart';

mixin FactoryRepository {
  /*
  *
  * Tested
  * Add new Factory
  *
  * */
  addNewFactory(
      {required String name,
      required String department,
      required String person,
      required String contactPhone,
      required bool isBlackList}) async {
    try {
      final dataFound =
          await KanSupabase.supabase.client.from("factories").select("*").match({
        "factory_name": name,
        "contact_phone": contactPhone,
        "department": department,
        "factory_representative": person
      }).select();

      if (dataFound.isNotEmpty) {
      } else {
        await KanSupabase.supabase.client.from("factories").upsert({
          "factory_name": name,
          "contact_phone": contactPhone,
          "department": department,
          "factory_representative": person
        });
      }
    } catch (e) {}
  }

  /*
  *
  * Tested
  * Update Factory
  *
  * */

  updateFactory(
      {required String id,
      required String department,
      required String person,
      required String contactPhone,
      required bool isBlackList}) async {
    try {
      final dataFound =
          await KanSupabase.supabase.client.from("factories").select("*").match({
        "factory_id": id,
      }).select();
      if (dataFound.isNotEmpty) {
        await KanSupabase.supabase.client.from("factories").update({
          "contact_phone": contactPhone,
          "department": department,
          "factory_representative": person,
          "isBlackList": isBlackList
        }).eq("factory_id", id);
      }
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
  Future<List<Map<String, dynamic>>> getAllfactories() async {
    try {
      final response = await KanSupabase.supabase.client.from("factories").select("*");
      //print(response.first);
      return response;
    } catch (e) {
      throw Exception('Error in get all factory: $e');
    }
  }
}
