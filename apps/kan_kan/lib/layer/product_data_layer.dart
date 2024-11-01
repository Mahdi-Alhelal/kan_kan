import 'package:kan_kan/model/product_model.dart';

class ProductDataLayer {
  List<ProductModel> products = [];
  ProductModel getProductOrder({required int id}) {
    return products.firstWhere((element) => element.productId == id);
  }
}
