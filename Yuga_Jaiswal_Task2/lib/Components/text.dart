import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final Color? color;
  final FontStyle? fontStyle;
  final double? fontSize;
  final FontWeight? fontweigth;

  const CustomText({
    required this.text,
    required this.fontStyle,
    required this.color,
    this.fontSize,
    this.fontweigth,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: color ?? Colors.white,
          fontSize: fontSize ?? 10,
          fontStyle: fontStyle ?? FontStyle.normal,
          fontWeight: fontweigth),
    );
  }
}
