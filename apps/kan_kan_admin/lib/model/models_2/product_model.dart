import 'package:kan_kan_admin/model/models_2/factory_model.dart';

class ProductModel {
  ProductModel({
    required this.width,
    required this.height,
    required this.length,
    required this.factory,
    required this.createdAt,
    required this.createdBy,
    required this.productId,
    required this.updatedAt,
    required this.updatedBy,
    required this.defaultPrice,
    required this.productName,
    required this.productDescription,
  });
  
  late int width;
  late int height;
  late int length;
  late FactoryModel factory;
  late String createdAt;
  late String createdBy;
  late final String productId;
  late String updatedAt;
  late String updatedBy;
  late num defaultPrice;
  late String productName;
  late String productDescription;

  ProductModel.fromJson(Map<String, dynamic> json) {
    width = json['width'] ?? 0;
    height = json['height'] ?? 0;
    length = json['length'] ?? 0;
    factory = FactoryModel.fromJson(json['factories']);
    createdAt = json['created_at'] ?? "";
    createdBy = json['created_by'] ?? "";
    productId = json['product_id'] ?? "";
    updatedAt = json['updated_at'] ?? "";
    updatedBy = json['updated_by'] ?? "";
    defaultPrice = json['default_price'] ?? 0;
    productName = json['product_name'] ?? "";
    productDescription = json['product_description'] ?? "";
  }

  Map<String, dynamic> toJson(int factoryId) {
    final _data = <String, dynamic>{};
    _data['product_id'] = productId;
    _data['width'] = width;
    _data['height'] = height;
    _data['length'] = length;
    _data['created_by'] = createdBy;
    _data['factory_id'] = factoryId;
    _data['product_id'] = productId;
    _data['updated_at'] = updatedAt;
    _data['updated_by'] = updatedBy;
    _data['default_price'] = defaultPrice;
    _data['product_name'] = productName;
    _data['product_description'] = productDescription;
    return _data;
  }
}
