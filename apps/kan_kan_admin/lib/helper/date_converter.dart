import 'package:ui/ui.dart';

class DateConverter {
  static final DateFormat _saDateFormate = DateFormat("yyyy/mm/dd");
  static final DateFormat _usDateFormate = DateFormat("yyyy-dd-mm");
  static String saDateFormate(String date) {
    return _saDateFormate.format(DateTime.parse(date)).toString();
  }

  static String usDateFormate(String date) {
    return _usDateFormate.format(DateTime.parse(date)).toString();
  }
}
