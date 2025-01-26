import 'package:flutter/material.dart';

/// TODO: Add font family here
const String arFontFamily = '';
const String emFontFamily = '';

TextStyle thinStyle({
  Color? color,
  double? fontSize,
  TextDecoration? decoration,
  double? lineHeight,
}) {
  return TextStyle(
    fontWeight: AppFontWeight.thin,
    fontFamily: arFontFamily,
    color: color,
    fontSize: fontSize,
    decoration: decoration,
    height: lineHeight,
  );
}

TextStyle extraLightStyle({
  Color? color,
  double? fontSize,
  TextDecoration? decoration,
  double? lineHeight,
}) {
  return TextStyle(
    fontWeight: AppFontWeight.extraLight,
    fontFamily: arFontFamily,
    color: color,
    fontSize: fontSize,
    decoration: decoration,
    height: lineHeight,
  );
}

TextStyle lightStyle({
  Color? color,
  double? fontSize,
  TextDecoration? decoration,
  double? lineHeight, required int height,
}) {
  return TextStyle(
    fontWeight: AppFontWeight.light,
    fontFamily: arFontFamily,
    color: color,
    fontSize: fontSize,
    decoration: decoration,
    height: lineHeight,
  );
}

TextStyle regularStyle({
  Color? color,
  double? fontSize,
  TextDecoration? decoration,
  double? lineHeight,
}) {
  return TextStyle(
    fontWeight: AppFontWeight.regular,
    fontFamily: arFontFamily,
    height: lineHeight,
    color: color,
    fontSize: fontSize,
    decoration: decoration,
    decorationColor: color,
  );
}

TextStyle mediumStyle({
  Color? color,
  double? fontSize,
  TextDecoration? decoration,
  double? lineHeight,
}) {
  return TextStyle(
    fontWeight: AppFontWeight.medium,
    fontFamily: arFontFamily,
    color: color,
    fontSize: fontSize,
    decoration: decoration,
    height: lineHeight,
    decorationColor: color,
  );
}

TextStyle semiBoldStyle({
  Color? color,
  double? fontSize,
  TextDecoration? decoration,
  double? lineHeight,
}) {
  return TextStyle(
    fontWeight: AppFontWeight.semiBold,
    fontFamily: arFontFamily,
    color: color,
    fontSize: fontSize,
    decoration: decoration,
    height: lineHeight,
    decorationColor: color,
  );
}

TextStyle boldStyle({
  Color? color,
  double? fontSize,
  TextDecoration? decoration,
  double? lineHeight,
}) {
  return TextStyle(
    height: lineHeight,
    fontWeight: AppFontWeight.bold,
    fontFamily: arFontFamily,
    color: color,
    fontSize: fontSize,
    decoration: decoration,
  );
}

class AppFontWeight {
  const AppFontWeight._();

  static const FontWeight thin = FontWeight.w100;
  static const FontWeight extraLight = FontWeight.w200;
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
}
