class UserModel {
  UserModel({
    required this.userId,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.balance,
    required this.userStatus,
    required this.role,
  });
  late String userId;
  late final String fullName;
  late final String email;
  late String phone;
  late double balance;
  late String userStatus;
  late String role;

  UserModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    fullName = json['full_name'];
    email = json['email'];
    phone = json['phone'];
    balance = json['balance'];
    userStatus = json['user_status'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data["user_id"] = userId;
    data['full_name'] = fullName;
    data['email'] = email;
    data['phone'] = phone;
    return data;
  }

  Map<String, dynamic> toJsonUpdate() {
    final data = <String, dynamic>{};
    data['phone'] = phone;
    data['balance'] = balance;

    return data;
  }
}
