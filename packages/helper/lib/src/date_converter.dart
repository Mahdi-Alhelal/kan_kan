import 'package:intl/intl.dart';

class DateConverter {
  static final DateFormat _saDateFormate = DateFormat("yyyy/MM/dd");
  static final DateFormat _usDateFormate = DateFormat("yyyy-dd-MM");
  static final DateFormat _supaDateFormate = DateFormat("yyyy-MM-dd");
  static String saDateFormate(String date) {
    return _saDateFormate.format(DateTime.parse(date)).toString();
  }

  static String usDateFormate(String date) {
    return _usDateFormate.format(DateTime.parse(date)).toString();
  }

  static supabaseDateFormate(String date) {
    return _supaDateFormate.format(DateTime.parse(date)).toString();
  }
}
