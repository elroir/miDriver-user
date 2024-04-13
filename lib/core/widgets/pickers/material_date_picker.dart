import 'package:flutter/material.dart';


class MaterialDatePickerWidget extends StatefulWidget {

  final TextEditingController? controller;
  final String? initialValue;
  final DateTime initialDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final List<int> selectableWeekDays;
  final String? Function(String?)? validator;
  final void Function(DateTime date)? onAcceptPressed;
  final InputDecoration? decoration;

  const MaterialDatePickerWidget({super.key,
    this.controller,
    this.initialValue,
    required this.initialDate,
    required this.firstDate,
    required this.lastDate,
    this.selectableWeekDays = const [1,2,3,4,5,6,7],
    this.validator,
    this.onAcceptPressed,
    this.decoration
  });

  @override
  State<MaterialDatePickerWidget> createState() => _MaterialDatePickerWidgetState();
}

class _MaterialDatePickerWidgetState extends State<MaterialDatePickerWidget> {

  late String? _date;

  @override
  void initState() {
    _date = widget.initialValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    if (_date!=''&&_date!=null&&widget.controller!.text.contains('/')){
      List<String> list = widget.controller!.text.split('/');

      int year = int.parse(list.removeLast());
      int month = int.parse(list.removeLast());
      int day = int.parse(list.removeLast());

      setState(() {
        _date = '${day.toString()}/${month.toString()}/${year.toString()}';
        widget.controller!.text = _date!;
      });
    }

    return TextFormField(
      enableInteractiveSelection: false ,
      keyboardType: TextInputType.datetime,
      controller: widget.controller,
      decoration: widget.decoration,
      onTap: (){
        FocusScope.of(context).requestFocus(FocusNode());
        _selectDate(context);
      },
      validator: widget.validator ?? (value) {
        if (value!.isEmpty) {
          return 'La fecha es obligatoria';
        }

        return null;
      },
    );
  }

  _selectDate(BuildContext context) async {

    DateTime initialDate = widget.initialDate;

    while(!widget.selectableWeekDays.contains(initialDate.weekday)){
      initialDate = initialDate.add(const Duration(days: 1));
    }


    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: widget.firstDate,
        selectableDayPredicate: (DateTime val) => widget.selectableWeekDays.contains(val.weekday),
        lastDate:widget.lastDate,
        locale: const Locale('es','ES'),
        fieldHintText: 'Dia/Mes/Año'
    );

    if (picked != null){

      if(widget.onAcceptPressed!=null){
        widget.onAcceptPressed!(picked);
      }
      setState(() {
        _date = '${picked.day.toString()}/${picked.month.toString()}/${picked.year.toString()}';
        widget.controller!.text = _date!;
      });
    }
  }
}