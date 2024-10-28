import 'package:kan_kan_admin/model/product_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../integrations/supabase/supabase_client.dart';

mixin ProductRepository {
  /*
  *
  * Tested
  * Add new Category
  *
  * */
  Future<void> addNewProduct(
      {required ProductModel product, required int factoryId}) async {
    try {
      await KanSupabase.supabase.client
          .from("products")
          .upsert(product.toJson(factoryId: factoryId));
    } on PostgrestException {
      throw Exception('Error: in add product');
    } catch (e) {
      throw Exception('Error: in add product: $e');
    }
  }

  /*
  *
  * Tested
  * Update Product
  *
  * */

  static updateProduct(
      {required ProductModel product, required int factoryId}) async {
    try {
      await KanSupabase.supabase.client
          .from("products")
          .update(product.toJson(factoryId: factoryId))
          .eq("product_id", product.productId);
    } on PostgrestException {
      throw Exception('Error: does not exit');
    } catch (e) {
      throw Exception('Error: in update product: $e');
    }
  }

  /*
  *
  * Tested
  * Delete Product
  *
  * */

  deleteProduct({required String id}) async {
    try {
      await KanSupabase.supabase.client
          .from("products")
          .delete()
          .eq("product_id", id)
          .select();
    } on PostgrestException {
      throw Exception('Error: product does exit');
    } catch (e) {
      throw Exception('Error: in delete product: $e');
    }
  }

  /*
  *
  * Tested
  * get all products
  *
  * */
  Future<List<ProductModel>> getAllProducts() async {
    try {
      final response = await KanSupabase.supabase.client
          .from("products")
          .select("*,factories(*)");
      print(response);
      return response.map((element) => ProductModel.fromJson(element)).toList();
    } on PostgrestException {
      throw Exception('Error: no products');
    } catch (e) {
      throw Exception('Error: in get all products: $e');
    }
  }
}
