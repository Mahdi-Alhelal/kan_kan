import '../../integrations/supabase/supabase_client.dart';

class ProductRepository {
  // Supabase client instance
  // final SupabaseClient _supabase = SupabaseService().client;

  /*
  *
  * Tested
  * Add new Category
  *
  * */
  static Future<List<Map<String, dynamic>>> addNewProduct(
      {required String name,
      required String productDescription,
      required double price,
      required double length,
      required double width,
      required double height,
      required String factoryId}) async {
    try {
      final dataFound = await supabase.client.from("products").insert({
        "product_name": name,
        "product_description": productDescription,
        "defult_price": price,
        "length": length,
        "width": width,
        "height": height,
        "factory_id": factoryId
      }).select(); // here we need to check if i can to deplicated or not
      return dataFound;
    } catch (e) {
      throw Exception('Error in add product: $e');
    }
  }

  /*
  *
  * Tested
  * Update Product
  *
  * */

  static updateProduct(
      {required String id,
      required String name,
      required String productDescription,
      required double price,
      required double length,
      required double width,
      required double height,
      required String factoryId}) async {
    try {
      final dataFound = await supabase.client
          .from("products")
          .select("*")
          .match({"product_id": id}).select();
      if (dataFound.isNotEmpty) {
        await supabase.client.from("products").update({
          "product_name": name,
          "product_description": productDescription,
          "defult_price": price,
          "length": length,
          "width": width,
          "height": height,
          "factory_id": factoryId
        }).eq("product_id", id);
      }
    } catch (e) {
      throw Exception('Error in update product: $e');
    }
  }

  /*
  *
  * Tested
  * Delete Product
  *
  * */

  static deleteProduct({required String id}) async {
    try {
      final dataFound = await supabase.client
          .from("deals")
          .select("*")
          .eq("product_id", id)
          .select();

      if (dataFound.isNotEmpty) {
      } else {
        await supabase.client
            .from("products")
            .delete()
            .eq("product_id", id)
            .select();
      }
    } catch (e) {
      throw Exception('Error in delete product: $e');
    }
  }

  /*
  *
  * Tested
  * get all products
  *
  * */
  static Future<List<Map<String, dynamic>>> getAllProducts() async {
    try {
      final response = await supabase.client.from("products").select("*");
      return response;
    } catch (e) {
      throw Exception('Error in get all products: $e');
    }
  }
}
