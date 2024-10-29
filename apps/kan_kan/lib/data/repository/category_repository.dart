import '../../integrations/supabase/supabase_client.dart';

mixin CategoryRepository {


  /*
  *
  * Tested
  * get all Categories
  *
  * */
  Future<List<Map<String, dynamic>>> getAllCategories() async {
    try {
      final response = await KanSupabase.supabase.client.from("categories").select("*");
      return response;
    } catch (e) {
      throw Exception('Error in get all categories: $e');
    }
  }
}
