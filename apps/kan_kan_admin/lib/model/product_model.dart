class ProductModel {
  late String id;
  late String productName;
  late String factory;
  late num wight;
  late num hight;
  late num width;
  late num length;
  late String modelNumber;
  late String description;
  ProductModel(
      {required this.modelNumber,
      required this.id,
      required this.description,
      required this.factory,
      required this.hight,
      required this.length,
      required this.productName,
      required this.width,
      required this.wight});
}
