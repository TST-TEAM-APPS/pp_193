import 'package:intl/intl.dart';

class DateHelper {
  static String formatDate(DateTime date) {
    String day = date.day.toString().padLeft(2, '0');
    String month = date.month.toString().padLeft(2, '0');
    String year = date.year.toString();
    return '$day.$month.$year';
  }

  static String formatMonthDateTime(DateTime dateTime) {
    DateFormat dayFormat = DateFormat('EEE');
    DateFormat monthFormat = DateFormat('MMM');
    String day = dateTime.day.toString();

    String dayOfWeek = dayFormat.format(dateTime);
    String month = monthFormat.format(dateTime);

    return '$dayOfWeek,$month,$day';
  }

  static String formatInTextDate(DateTime date) {
    const List<String> months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];

    const List<String> days = [
      'Monday','Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday',
    ];

    String day = days[date.weekday - 1];
    String month = months[date.month - 1];
    int year = date.year % 1000;

    return '$day $month, $year';
  }
}