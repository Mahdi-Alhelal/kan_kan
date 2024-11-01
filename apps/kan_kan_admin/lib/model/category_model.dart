class CategoryModel {
  late int categoryId;
  late String categoryName;

  CategoryModel({required this.categoryId, required this.categoryName});
  CategoryModel.empty();
  CategoryModel.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'] ?? 0;
    categoryName = json['category_name'] ?? "";
  }
  toJson() {
    final data = <String, dynamic>{};
    data['category_id'] = categoryId;
    data['category_name'] = categoryName;
    
    return data;
  }
}
