import 'package:helper/src/enums.dart';

class DropMenuList {
  static List<bool> factoryStatus = [false, true];

  static List<String> paymentStatus = ["مدفوع ", "مسترجع"];

  static List<String> shipmentStatus = [
    "processing",
    "pending",
    "inChina",
    "inTransit",
    "inSaudi",
    "withShipmentCompany",
    "completed",
    'canceled',
  ];

  static List<String> dealStatus = [
    "completed",
    'active',
    'pending',
    'closed',
    'private',
    'processing'
  ];


  static Map<UserStatusEnum, String> userStatusTranslations = {
    UserStatusEnum.active: 'نشط',
    UserStatusEnum.blocked: 'محجوب'
  };

}
