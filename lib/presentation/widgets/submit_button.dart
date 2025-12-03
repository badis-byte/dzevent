import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String title;
  final Color bgColor;
  final Color textColor;
  final void Function()? onPressed;

  const Button({
    super.key,
    required this.title,
    required this.bgColor,
    required this.textColor,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          textStyle: TextStyle(fontWeight: FontWeight.bold, color: textColor),
        ),
        child: Text(
          title,
          style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
