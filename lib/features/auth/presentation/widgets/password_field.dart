import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/resources/strings_manager.dart';

class PasswordField extends StatefulWidget {

  final String labelText;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final TextInputAction? textInputAction;

  const PasswordField({Key? key,this.labelText = AppStrings.passwordField, this.validator, this.onSaved, this.onChanged, this.onFieldSubmitted, this.textInputAction}) : super(key: key);

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {

  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator,
      obscureText: !isVisible,
      textInputAction: widget.textInputAction,
      onFieldSubmitted: widget.onFieldSubmitted,
      onSaved: widget.onSaved,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
          labelText: widget.labelText,
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              isVisible = !isVisible;
            });
          },
            child: Icon(isVisible ? Iconsax.eye :Iconsax.eye_slash)
        )
      ),
    );
  }
}

