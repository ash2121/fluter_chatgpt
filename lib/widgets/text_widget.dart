import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final String label;
  final Color? color;
  final double fontsize = 15;
  final FontWeight? fontWeight;

  const TextWidget({
    super.key,
    required this.label,
    this.color,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Text(
        label,
        style: TextStyle(
            color: color ?? Colors.white,
            fontSize: fontsize,
            fontWeight: fontWeight ?? FontWeight.w500),
      ),
    );
  }
}
