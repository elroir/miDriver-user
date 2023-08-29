import 'package:flutter/material.dart';

import '../../../../../core/resources/values_manager.dart';

class MainPicker<T> extends StatelessWidget {


  final List<String> itemTexts;
  final List<T>? items;
  final String title;
  final TextEditingController textEditingController;
  final void Function(String,T?) onChanged;
  final bool required;
  final Widget? icon;
  final Color? backgroundColor;

  MainPicker({
    super.key,
    required this.itemTexts,
    this.items,
    this.title = '',
    required this.textEditingController,
    required this.onChanged,
    this.required = true,
    this.icon,
    this.backgroundColor
  })  : assert(itemTexts.length == items!.length,
      'itemTexts list and items list should have same number of elements');

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if(title!='')
          Text(title,style: Theme.of(context).textTheme.titleMedium),
        TextFormField(
          controller: textEditingController,
          readOnly: true,
          decoration: InputDecoration(
            fillColor: backgroundColor,
            suffixIcon: const Icon(Icons.arrow_drop_down,color: Colors.black87,size: 32),
            prefixIcon: icon
          ),
            validator: (val) {
              if(required && val!.isEmpty){
                return 'Campo requerido';
              }
              return null;
            },
            onTap: () => showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(AppBorder.cardBorderRadius))),
                builder: (context) {
                  return SafeArea(
                    bottom: true,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(AppBorder.cardBorderRadius)),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                            minHeight: 100,
                            maxHeight: 300
                        ),
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: itemTexts.length,
                            itemBuilder: (_, i) => Container(
                              color: (i.isEven)
                                  ? Theme.of(context).primaryColor
                                  : Colors.transparent,
                              child: ListTile(
                                onTap: () {
                                  textEditingController.text = itemTexts[i];
                                  onChanged(itemTexts[i],items?[i]);
                                  Navigator.pop(context);
                                },
                                title: Text(
                                  itemTexts[i],
                                  style: Theme.of(context).textTheme.titleMedium,
                                ),
                              ),
                            )),
                      ),
                    ),
                  );
                })
        ),
      ],
    );
  }
}