import 'package:flutter/cupertino.dart';

import 'color_res.dart';

// ignore: non_constant_identifier_names
TextStyle AppTextStyle({
  FontWeight? weight,
  double ?fontSize,
  Color? color,
  TextDecoration ?decoration,
}) {
  return TextStyle(
    fontWeight: weight ?? FontWeight.normal,
    fontSize: fontSize ?? 16,
    color: color ?? ColorRes.white,
    decoration: decoration ?? TextDecoration.none,
  );
}
