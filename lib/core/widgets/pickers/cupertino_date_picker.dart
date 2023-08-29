import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class CupertinoDatePickerWidget extends StatefulWidget {

  final TextEditingController? controller;
  final String? initialValue;
  final DateTime initialDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final List<int> selectableWeekDays;
  final String? Function(String?)? validator;
  final void Function(DateTime date)? onAcceptPressed;
  final InputDecoration? decoration;


  const CupertinoDatePickerWidget({Key? key,
    this.controller,
    this.initialValue,
    required this.initialDate,
    required this.firstDate,
    required this.lastDate,
    this.selectableWeekDays = const [1,2,3,4,5,6,7],
    this.validator,
    this.onAcceptPressed,
    this.decoration
  }) : super(key: key);

  @override
  State<CupertinoDatePickerWidget> createState() => _CupertinoDatePickerWidgetState();
}

class _CupertinoDatePickerWidgetState extends State<CupertinoDatePickerWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enableInteractiveSelection: false ,
      keyboardType: TextInputType.datetime,
      controller: widget.controller,
      decoration: widget.decoration,
      onTap: (){
        FocusScope.of(context).requestFocus(FocusNode());
        _selectDate();
      },
      validator: widget.validator ?? (value) {
        if (value!.isEmpty) {
          return 'La fecha es obligatoria';
        }
        return null;
      },
    );
  }

  _selectDate() async {
    StreamController<DateTime> dateStreamController = StreamController<DateTime>.broadcast();

    DateTime initialDate = widget.initialDate;

    while(!widget.selectableWeekDays.contains(initialDate.weekday)){
      initialDate = initialDate.add(const Duration(days: 1));
    }
    DateTime date = initialDate;


    await showCupertinoModalPopup(
        context: context,
      builder: (context) => CupertinoActionSheet(
        actions: [
          SizedBox(
            height: 180,
            child: CupertinoDatePicker(
              minimumDate: widget.firstDate,
              maximumDate: widget.lastDate,
              initialDateTime: widget.initialDate,
              mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: (dateTime){
                date = dateTime;
                dateStreamController.add(dateTime);
              },
            ),
          )

        ],
        cancelButton: CupertinoButton(
            onPressed: () {
              widget.controller!.text = '${date.day.toString()}/${date.month.toString()}/${date.year.toString()}';
              if(widget.onAcceptPressed!=null){
                widget.onAcceptPressed!(date);
              }
              dateStreamController.close();
              Navigator.of(context).pop();
            } ,
            child: const Text('Listo')
        ),
      )

    );

  }
}
