import 'dart:io';

import 'package:flutter/material.dart';

import 'cupertino_date_picker.dart';
import 'material_date_picker.dart';



class DatePickerWidget extends StatelessWidget{


  final TextEditingController? controller;
  final String? initialValue;
  final DateTime initialDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final double widthFactor;
  final List<int> selectableWeekDays;
  final String? Function(String?)? validator;
  final void Function(DateTime date)? onAcceptPressed;
  final InputDecoration? decoration;

  DatePickerWidget({
    Key? key,
    this.controller,
    this.initialValue,
    initialDate,
    firstDate,
    lastDate,
    this.widthFactor = 1,
    this.selectableWeekDays = const [1,2,3,4,5,6,7],
    this.validator,
    this.onAcceptPressed,
    this.decoration,

  }) :  initialDate = initialDate ?? DateTime.now(),
        firstDate = firstDate ?? DateTime(1940),
        lastDate  = lastDate  ?? DateTime.now(), super(key: key);



  @override
  Widget build(BuildContext context) {

    return FractionallySizedBox(
      widthFactor: widthFactor,
      child: Platform.isIOS
          ? CupertinoDatePickerWidget(
        key: key,
        controller: controller,
        initialValue: initialValue,
        decoration: decoration,
        initialDate: initialDate,
        firstDate: firstDate,
        lastDate: lastDate,
        selectableWeekDays: selectableWeekDays,
        validator: validator,
        onAcceptPressed: onAcceptPressed,
      ) : MaterialDatePickerWidget(
        key: key,
        controller: controller,
        initialValue: initialValue,
        decoration: decoration,
        initialDate: initialDate,
        firstDate: firstDate,
        lastDate: lastDate,
        selectableWeekDays: selectableWeekDays,
        validator: validator,
        onAcceptPressed: onAcceptPressed,
      ),
    );
  }

}
