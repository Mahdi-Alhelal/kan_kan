class FactoryModel {
  FactoryModel({
    required this.region,
    required this.department,
    required this.factoryId,
    required this.isBlackList,
    required this.factoryName,
    required this.contactPhone,
    required this.factoryRepresentative,
  });
  FactoryModel.empty();
  late String region;
  late String department;
  late int factoryId;
  late bool isBlackList;
  late String factoryName;
  late String contactPhone;
  late String factoryRepresentative;

  FactoryModel.fromJson(Map<String, dynamic> json) {
    factoryId = json['factory_id'] ?? 0;
    region = json['region'] ?? "";
    department = json['department'] ?? "";
    factoryId = json['factory_id'] ?? 0;
    isBlackList = json['is_black_list'] ?? false;
    factoryName = json['factory_name'] ?? "";
    contactPhone = json['contact_phone'] ?? "";
    factoryRepresentative = json['factory_representative'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['region'] = region;
    data['department'] = department;
    data['is_black_list'] = isBlackList;
    data['factory_name'] = factoryName;
    data['contact_phone'] = contactPhone;
    data['factory_representative'] = factoryRepresentative;
    return data;
  }
}
