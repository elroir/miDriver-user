import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {


  String toLiteralDateAndTime(BuildContext context) {
    final languageCode = Localizations.localeOf(context).languageCode;
    final dateFormat = DateFormat.yMMMMd(languageCode);

    return '${dateFormat.format(this)} ${TimeOfDay.fromDateTime(this).format(context)}';
  }


}