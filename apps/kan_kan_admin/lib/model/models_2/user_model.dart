class UserModel {
  UserModel({
    required this.userId,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.profileUrl,
    required this.balance,
    required this.userStatus,
    required this.role,
  });
  late final String userId;
  late final String fullName;
  late final String email;
  late final String phone;
  late final String profileUrl;
  late final double balance;
  late final String userStatus;
  late final String role;

  UserModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    fullName = json['full_name'];
    email = json['email'];
    phone = json['phone'];
    profileUrl = json['profile_url'];
    balance = json['balance'];
    userStatus = json['user_status'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['user_id'] = userId;
    _data['full_name'] = fullName;
    _data['email'] = email;
    _data['phone'] = phone;
    _data['profile_url'] = profileUrl;
    _data['balance'] = balance;
    _data['user_status'] = userStatus;
    _data['role'] = role;
    return _data;
  }
}
