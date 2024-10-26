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
  late final String region;
  late final String createdAt;
  late final String createdBy;
  late final String department;
  late final String factoryId;
  late final String updatedAt;
  late final String updatedBy;
  late final bool isBlackList;
  late final String factoryName;
  late final String contactPhone;
  late final String factoryRepresentative;

  FactoryModel.fromJson(Map<String, dynamic> json) {
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
