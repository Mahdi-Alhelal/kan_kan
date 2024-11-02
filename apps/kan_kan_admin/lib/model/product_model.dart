import 'package:kan_kan_admin/model/factory_model.dart';
import 'package:kan_kan_admin/model/image_model.dart';

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
      required this.modelNumber,
      required this.weight,
      required this.images});
  ProductModel.noFactory(
      {required this.width,
      required this.height,
      required this.length,
      required this.productId,
      required this.defaultPrice,
      required this.productName,
      required this.productDescription,
      required this.modelNumber,
      required this.weight});
  late num width;
  late num height;
  late num length;
  late num weight;
  late FactoryModel factory;
  late final int productId;
  late num defaultPrice;
  late String productName;
  late String productDescription;
  late String modelNumber;
  late List<ImageModel> images;

  ProductModel.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'] ?? 0;
    width = json['width'] ?? 0;
    height = json['height'] ?? 0;
    length = json['length'] ?? 0;
    weight = json["wight"] ?? 0;
    modelNumber = json['model_number'] ?? "";
    factory = FactoryModel.fromJson(json['factories']);
    defaultPrice = json['default_price'] ?? 0.0;
    productName = json['product_name'] ?? "";
    productDescription = json['product_description'] ?? "";

    images = List.from(json['product_images'])
        .map((e) => ImageModel.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson({required int factoryId}) {
    final data = <String, dynamic>{};
    data['width'] = width;
    data['height'] = height;
    data['length'] = length;
    data["weight"] = weight;
    data['factory_id'] = factoryId;
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
    data["weight"] = weight;
    data['factory'] = factory.toJson();
    data['product_id'] = productId;
    data['default_price'] = defaultPrice;
    data['product_name'] = productName;
    data['product_description'] = productDescription;
    data["model_number"] = modelNumber;
    return data;
  }
}
