import 'package:flutter/material.dart';

class FormattedNumberText extends StatelessWidget {
  final int number;
  final TextStyle? style;

  FormattedNumberText({super.key, required this.number, this.style});

  String formatNumber(int number) {
    String numberString = number.toString();
    if (numberString.length > 1) {
      return '${numberString[0]} ${numberString.substring(1)}';
    } else {
      return numberString;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      formatNumber(number),
      style: style ?? const TextStyle(fontSize: 24),
    );
  }
}
