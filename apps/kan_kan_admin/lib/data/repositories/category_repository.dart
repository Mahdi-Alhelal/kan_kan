import '../../integrations/supabase/supabase_client.dart';

mixin CategoryRepository {
  // Supabase client instance
  // final SupabaseClient _supabase = SupabaseService().client;

  /*
  *
  * Tested
  * Add new Category
  *
  * */
  Future<List<Map<String, dynamic>>> addNewCategory(
      {required String name}) async {
    try {
      final dataFound = await KanSupabase.supabase.client.from("categories").upsert({
        "category_name": name
      }).select(); // here we need to check if i can to deplicated or not
      return dataFound;
    } catch (e) {
      throw Exception('Error in add category: $e');
    }
  }

  /*
  *
  * Tested
  * Update Category
  *
  * */

  updateCategory({required String id, required String name}) async {
    try {
      final dataFound = await KanSupabase.supabase.client
          .from("categories")
          .select("*")
          .match({"category_id": id}).select();
      if (dataFound.isNotEmpty) {
        await KanSupabase.supabase.client
            .from("categories")
            .update({"category_name": name}).eq("category_id", id);
      }
    } catch (e) {
      throw Exception('Error in update category: $e');
    }
  }

  /*
  *
  * Tested
  * Delete Category
  *
  * */

  deleteCategory({required String id}) async {
    try {
      final dataFound = await KanSupabase.supabase.client
          .from("deals")
          .select("*")
          .eq("category_id", id)
          .select();

      if (dataFound.isNotEmpty) {
      } else {
        await KanSupabase.supabase.client
            .from("categories")
            .delete()
            .eq("category_id", id)
            .select();
      }
    } catch (e) {
      throw Exception('Error in update category: $e');
    }
  }

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
      throw Exception('Error in update category: $e');
    }
  }
}
