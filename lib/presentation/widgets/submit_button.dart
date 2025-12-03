import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final String title;
  final Color bgColor;
  final Color textColor;

  const SubmitButton({
    super.key,
    required this.title,
    required this.bgColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {},
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
