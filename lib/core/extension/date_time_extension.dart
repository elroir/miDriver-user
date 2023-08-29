import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {


  String toLiteralDateAndTime(BuildContext context) {
    final languageCode = Localizations.localeOf(context).languageCode;
    final dateFormat = DateFormat.yMMMMd(languageCode);

    return '${dateFormat.format(this)} ${TimeOfDay.fromDateTime(this).format(context)}';
  }


  DateTime toDateTimeFromDateAndTimeString(String date,String time) {
    final dateList = date.split('/');
    final timeList = time.split(':');

    final year = int.parse(dateList[2]);
    final month = int.parse(dateList[1]);
    final day = int.parse(dateList[0]);

    final hour = int.parse(timeList[0]);
    final minute = int.parse(timeList[1]);

    return DateTime(year,month,day,hour,minute);
  }


}