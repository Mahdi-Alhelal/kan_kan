enum UserStatusEnum { active, blocked }

extension UserStatusExt on UserStatusEnum {
  String get value {
    switch (this) {
      case UserStatusEnum.active:
        return "نشط";
      case UserStatusEnum.blocked:
        return "محجوب";
    }
  }
}
