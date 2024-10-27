import 'package:kan_kan_admin/model/models_2/factory_model.dart';

class ProductModel {
  ProductModel(
      {required this.width,
      required this.height,
      required this.length,
      required this.factory,
      required this.productId,
      required this.defaultPrice,
      required this.productName,
      required this.productDescription,
      required this.modelNumber});

  late num width;
  late num height;
  late num length;
  late FactoryModel factory;
  late final int productId;
  late num defaultPrice;
  late String productName;
  late String productDescription;
  late String modelNumber;

  ProductModel.fromJson(Map<String, dynamic> json) {
    width = json['width'] ?? 0;
    height = json['height'] ?? 0;
    length = json['length'] ?? 0;
    modelNumber = json['model_number'] ?? "";
    factory = FactoryModel.fromJson(json['factories']);
    productId = json['product_id'] ?? 0;
    defaultPrice = json['default_price'] ?? 0.0;
    productName = json['product_name'] ?? "";
    productDescription = json['product_description'] ?? "";
  }

  Map<String, dynamic> toJson({required int factoryId}) {
    final data = <String, dynamic>{};
    data['product_id'] = productId;
    data['width'] = width;
    data['height'] = height;
    data['length'] = length;
    data['factory_id'] = factoryId;
    data['product_id'] = productId;
    data['default_price'] = defaultPrice;
    data['product_name'] = productName;
    data['product_description'] = productDescription;
    data["model_number"] = modelNumber;
    return data;
  }

  Map<String, dynamic> print() {
    final data = <String, dynamic>{};
    data['product_id'] = productId;
    data['width'] = width;
    data['height'] = height;
    data['length'] = length;
    data['factory'] = factory.toJson();
    data['product_id'] = productId;
    data['default_price'] = defaultPrice;
    data['product_name'] = productName;
    data['product_description'] = productDescription;
    data["model_number"] = modelNumber;
    return data;
  }
}
