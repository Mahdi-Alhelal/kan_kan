import 'package:kan_kan_admin/model/product_model.dart';

class ProductDataLayer {
  List<ProductModel> products = [];
  ProductModel getProductOrder({required int id}) {
    return products.firstWhere(
      (element) => element.productId == id,
      orElse: () => ProductModel.noFactory(
        width: 0,
        height: 0,
        length: 0,
        productId: id,
        defaultPrice: 0.0,
        productName: 'Unknown Product',
        productDescription: '',
        modelNumber: '',
        weight: 0,
      ),
    );
  }
}
