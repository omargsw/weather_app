import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../styles/app_text_style.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.controller,
    this.hintText,
    this.readOnly = false,
    this.obscureText = false,
    this.validator,
    this.keyboardType,
    this.inputFormatters,
    this.maxLength,
    this.onTap,
    this.enabled,
    this.suffixIcon,
    this.prefixIcon,
    this.onChanged,
    this.onFieldSubmitted,
    this.onEditingComplete,
    this.fillColor,
    this.textDirection,
    this.showCounter = false,
    this.maxLines = 1,
  });

  final String? hintText;
  final bool readOnly;
  final bool showCounter;
  final bool? enabled;
  final bool obscureText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final int? maxLength;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color? fillColor;
  final int? maxLines;
  final void Function()? onTap;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final void Function()? onEditingComplete;
  final List<TextInputFormatter>? inputFormatters;
  final TextDirection? textDirection;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textDirection: textDirection,
      controller: controller,
      readOnly: readOnly,
      enabled: enabled,
      onFieldSubmitted: onFieldSubmitted,
      onEditingComplete: onEditingComplete,
      onChanged: onChanged,
      maxLines: maxLines,
      buildCounter: (context,
          {required currentLength, required isFocused, maxLength}) {
        return Container(
          transform: Matrix4.translationValues(0, -30, 0),
          child: Text(
            "($currentLength/$maxLength)",
            style: regularStyle(fontSize: 12, color: Color(0xff808089)),
          ),
        );
      },
      decoration: InputDecoration(
        hintText: hintText,
        counterText: showCounter ? null : "",
        fillColor: fillColor,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
      ),
      obscureText: obscureText,
      maxLength: maxLength,
      validator: validator,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      onTap: onTap,
    );
  }
}
