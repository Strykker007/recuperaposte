import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final bool autoFocus;
  final String? initialValue;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;
  final bool obscureText;
  final TextInputType? textInputType;
  final String label;
  const TextFieldWidget({
    Key? key,
    this.autoFocus = false,
    this.initialValue,
    this.prefixIcon,
    this.validator,
    this.obscureText = false,
    this.textInputType = TextInputType.text,
    this.label = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: autoFocus,
      keyboardType: textInputType,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        prefixIcon: prefixIcon,
        labelText: label,
      ),
      validator: validator,
    );
  }
}
