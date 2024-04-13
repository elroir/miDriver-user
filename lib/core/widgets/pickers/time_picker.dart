
import 'package:flutter/material.dart';

class TimePicker extends StatefulWidget {

  final TextEditingController? controller;
  final InputDecoration? decoration;
  final TimeOfDay? initialTime;
  final double widthFactor;
  final void Function()? onPressed;
  final FormFieldValidator<String>? validator;

  const TimePicker({super.key, this.controller, this.decoration,this.initialTime,this.widthFactor = 1,this.onPressed, this.validator});

  @override
  TimePickerState createState() => TimePickerState();
}

class TimePickerState extends State<TimePicker> {
  late TimeOfDay? _picked;


  @override
  Widget build(BuildContext context) {

    return FractionallySizedBox(
      widthFactor: widget.widthFactor,
      child: TextFormField(
        enableInteractiveSelection: false ,
        keyboardType: TextInputType.datetime,
        controller:widget.controller,
        onTap: (){
          FocusScope.of(context).requestFocus(FocusNode());
          _selectTime(context);
        },
        decoration: widget.decoration,
        validator: (widget.validator!=null) ? widget.validator : (value) {
          if(value!.length < 2) {
            return 'Campo obligatoiro';
          } else {
            return null;
          }
        },
      ),
    );
  }

  Future<void> _selectTime(BuildContext context) async {
    _picked = await showTimePicker(
      context: context,
      initialEntryMode: TimePickerEntryMode.input,
      initialTime: widget.initialTime ?? TimeOfDay.now(),
    );

    if (_picked != null ){
      String minute = _picked!.minute < 10 ? '0${_picked!.minute}' : _picked!.minute.toString();
      setState(() {
        widget.controller!.text = '${_picked!.hour}:$minute';
      });
      if (widget.onPressed!=null){
        widget.onPressed!();
      }
    }

  }
}

