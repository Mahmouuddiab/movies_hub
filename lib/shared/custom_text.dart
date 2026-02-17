import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
   CustomText({
    super.key,
    required this.text,
    this.maxLines,
    this.fontSize,
    this.fontWeight,
    this.color,
    this.flow,
    this.letterSpacing
  });
  final String text;
  final int? maxLines;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final TextOverflow? flow;
  double? letterSpacing;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        overflow: flow,
        letterSpacing: letterSpacing

      ),
    );
  }
}
