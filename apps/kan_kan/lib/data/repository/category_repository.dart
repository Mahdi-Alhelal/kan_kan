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
      final response =
          await KanSupabase.supabase.client.from("categories").select("*");
      return response;
    } catch (e) {
      throw Exception('Error in get all categories: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getOneCategory(
      {required String category}) async {
    try {
      final response = await KanSupabase.supabase.client
          .from("categories")
          .update({"category_name": category}).select();
      return response;
    } catch (e) {
      throw Exception('Error in get one category: $e');
    }
  }

  Future<List<Map<String, dynamic>>> deleteCategory(
      {required String category}) async {
    try {
      final response = await KanSupabase.supabase.client
          .from("categories")
          .delete()
          .eq("category_id", category);
      return response;
    } catch (e) {
      throw Exception('Error in get one category: $e');
    }
  }
}
