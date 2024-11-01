import 'package:kan_kan_admin/model/category_model.dart';

import '../../integrations/supabase/supabase_client.dart';

mixin CategoryRepository {

  /*
  *
  * Tested
  * Add new Category
  *
  * */
  Future addNewCategory(
      {required String name}) async {
    try {
     await KanSupabase.supabase.client
          .from("categories")
          .upsert({"category_name": name});
      return true;
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
  Future<List<CategoryModel>> getAllCategories() async {
    try {
      final response =
          await KanSupabase.supabase.client.from("categories").select("*");
      return response.map((element)=>CategoryModel.fromJson(element)).toList();
    } catch (e) {
      throw Exception('Error in update category: $e');
    }
  }
}
