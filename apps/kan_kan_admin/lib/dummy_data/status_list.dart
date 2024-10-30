import 'package:helper/src/enums.dart';

class DropMenuList {
  static List<bool> factoryStatus = [false, true];

  static List<String> paymentStatus = ["مدفوع ", "مسترجع"];

  static List<String> shipmentStatus = [
    "مكتمل",
    "تم إرسال الطلب",
    "تم إرسال الطلب",
    "في المستودع الصين",
    "في الشحن",
    "في سعودية",
    "ملغي"
  ];

  static List<String> dealStatus = ["خاص", "مغلق", "متاح"];

  //static List<String> userStatus = ["نشط", "محجوب"];

  static Map<UserStatusEnum, String> userStatusTranslations = {
    UserStatusEnum.active: 'نشط',
    UserStatusEnum.blocked: 'محجوب'
  };

  static List<String> productName = ["كامراة", "شاشة"];
  static List<String> dealCategory = ["اثاث", "الكترونيات"];
}
