class ProductModel {
  ProductModel(
      {required this.width,
      required this.height,
      required this.length,
      required this.productId,
      required this.defaultPrice,
      required this.productName,
      required this.productDescription,
      required this.modelNumber,
      required this.imgList,
      required this.wight});

  late num width;
  late num height;
  late num length;
  late num wight;
  late final int productId;
  late num defaultPrice;
  late String productName;
  late String productDescription;
  late String modelNumber;
  late List imgList;

  ProductModel.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'] ?? 0;
    width = json['width'] ?? 0;
    height = json['height'] ?? 0;
    length = json['length'] ?? 0;
    wight = json["wight"] ?? 0;
    modelNumber = json['model_number'] ?? "";
    defaultPrice = json['default_price'] ?? 0.0;
    productName = json['product_name'] ?? "";
    imgList = List.generate(json["product_images"].length,
        (int index) => json["product_images"][index]["image_url"]).toList();
    productDescription = json['product_description'] ?? "";
  }

  Map<String, dynamic> toJson({required int factoryId}) {
    final data = <String, dynamic>{};
    data['width'] = width;
    data['height'] = height;
    data['length'] = length;
    data["wight"] = wight;
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
    data["wight"] = wight;
    data['product_id'] = productId;
    data['default_price'] = defaultPrice;
    data['product_name'] = productName;
    data['product_description'] = productDescription;
    data["model_number"] = modelNumber;
    return data;
  }
}
