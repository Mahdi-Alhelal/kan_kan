import 'package:helper/src/enums.dart';

class DropMenuList {
  static List<bool> factoryStatus = [false, true];

  static List<String> paymentStatus = ["paid", "refund", "failed"];

  static List<String> shipmentStatus = [
    "pending",
    "processing",
    "inChina",
    "inTransit",
    "inSaudi",
    "withShipmentCompany",
    "completed",
    'canceled',
  ];

  static List<String> dealStatus = [
    'pending',
    'active',
    'private',
    'processing',
    'closed',
    'completed',
  ];

  static Map<UserStatusEnum, String> userStatusTranslations = {
    UserStatusEnum.active: 'نشط',
    UserStatusEnum.blocked: 'محجوب'
  };
}
