class FactoryModel {
  FactoryModel({
    required this.region,
    required this.createdAt,
    required this.createdBy,
    required this.department,
    required this.factoryId,
    required this.updatedAt,
    required this.updatedBy,
    required this.isBlackList,
    required this.factoryName,
    required this.contactPhone,
    required this.factoryRepresentative,
  });

  late String region;
  late String createdAt;
  late String createdBy;
  late String department;
  late int factoryId;
  late String updatedAt;
  late String updatedBy;
  late bool isBlackList;
  late String factoryName;
  late String contactPhone;
  late String factoryRepresentative;

  FactoryModel.fromJson(Map<String, dynamic> json) {
    factoryId = json['factory_id'] ?? 0;
    region = json['region'] ?? "";
    createdAt = json['created_at'] ?? "";
    createdBy = json['created_by'] ?? "";
    department = json['department'] ?? "";
    factoryId = json['factory_id'] ?? "";
    updatedAt = json['updated_at'] ?? "";
    updatedBy = json['updated_by'] ?? "";
    isBlackList = json['is_black_list'] ?? true;
    factoryName = json['factory_name'] ?? "";
    contactPhone = json['contact_phone'] ?? "";
    factoryRepresentative = json['factory_representative'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['factory_id'] = factoryId;
    _data['region'] = region;
    _data['department'] = department;
    _data['factory_id'] = factoryId;
    _data['updated_by'] = updatedBy;
    _data['is_black_list'] = isBlackList;
    _data['factory_name'] = factoryName;
    _data['contact_phone'] = contactPhone;
    _data['factory_representative'] = factoryRepresentative;
    return _data;
  }
}
