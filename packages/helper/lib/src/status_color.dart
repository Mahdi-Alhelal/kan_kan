
import 'dart:ui';
Color statusColors({required String status}) {
  switch (status) {
    case "نشط":
      return const Color(0xff0CAF60);

    case "غير نشط":
      return const Color(0xFFF44336);

    case "قيد المراجعة":
      return const Color(0xFFFF9800);

    default:
      return const Color(0xFF000000);
  }
}
