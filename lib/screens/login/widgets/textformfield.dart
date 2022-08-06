import 'package:ecitykiosk/utils/app_colors.dart';
import 'package:flutter/material.dart';

class TextCommonField extends StatelessWidget {
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final String? hintText, labelText;
  final bool? readOnly, obscureText;
  final Widget? suffix;
  final Color? inlineBorderColor;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onChanged;

  const TextCommonField(
      {Key? key,
      this.controller,
      this.onChanged,
      this.suffix,
      this.readOnly,
      this.inlineBorderColor,
      this.obscureText,
      this.textInputAction,
      required this.validator,
      this.hintText,
      this.labelText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    InputBorder inputBorder = UnderlineInputBorder(
        borderSide: BorderSide(color: inlineBorderColor ?? AppColors.appColor));
    return TextFormField(
      controller: controller,
      validator: validator,
      onChanged: onChanged,
      readOnly: readOnly ?? false,
      textInputAction: textInputAction,
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
          hintText: hintText,
          focusedBorder: inputBorder,
          suffixIcon: suffix,
          enabledBorder: inputBorder,
          border: inputBorder,
          labelText: labelText,
          hintStyle: const TextStyle(
              fontFamily: "Josefin_Sans",
              color: Color(0xFF717171),
              fontStyle: FontStyle.italic,
              fontSize: 14,
              fontWeight: FontWeight.w400)),
    );
  }
}
