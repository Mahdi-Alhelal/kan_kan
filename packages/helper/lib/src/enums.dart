enum UserStatusEnum { active, blocked }

extension UserStatusExt on UserStatusEnum {
  String get value {
    switch (this) {
      case UserStatusEnum.active:
        return "active";
      case UserStatusEnum.blocked:
        return "blocked";
    }
  }
}
