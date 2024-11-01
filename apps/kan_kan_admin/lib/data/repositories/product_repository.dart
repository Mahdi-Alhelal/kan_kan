import 'dart:io';

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
  Future<int> addNewProduct({
    required ProductModel product,
    required int factoryId,
  }) async {
    try {
      final productId = await KanSupabase.supabase.client
          .from("products")
          .upsert(product.toJson(factoryId: factoryId))
          .select('product_id');
      return productId.first['product_id'];
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

  updateProduct({required ProductModel product, required int factoryId}) async {
    try {
      await KanSupabase.supabase.client
          .from("products")
          .update(product.toJson(factoryId: factoryId))
          .eq("product_id", product.productId);
      return true;
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
          .select("*,factories(*),product_images(id,image_url)");
      print(response.last);
      return response.map((element) => ProductModel.fromJson(element)).toList();
    } on PostgrestException {
      throw Exception('Error: no products');
    } catch (e) {
      throw Exception('Error: in get all products: $e');
    }
  }

  uploadProductsImages(
      {required List<File> images, required int productId}) async {
    try {
      List<Future> uploadAction = [];
      for (var element in images) {
        uploadAction.add(uploadImage(productId: productId, image: element));
      }
      await Future.wait(uploadAction);
      return true;
    } catch (e) {
      throw Exception('Error: in upload all images : $e');
    }
  }

  Future uploadImage({required int productId, required File image}) async {
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
          .from("product_images")
          .upsert({"image_url": imageUrl, "product_id": productId});
      return true;
    } catch (e) {
      throw Exception('Error: in upload this image to database: $e');
    }
  }
}
