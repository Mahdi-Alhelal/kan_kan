import 'package:flutter/material.dart';
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

  static Widget differenceInDays({required String endDate}) {
    final date = DateTime.parse(endDate);
    if (DateTime.now().isBefore(date)) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.redAccent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Icon(
              Icons.calendar_month,
              size: 20,
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              '${date.difference(DateTime.now()).inDays + 1} يوم/أيام',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      );
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        "منتهي",
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  static String? formatTime(String? dateTimeString) {
  DateTime dateTime = DateTime.parse(dateTimeString!);
  // Format time as HH:MM:SS
  return "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
}
}
