import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  final String title;
  final String label;
  final IconData icon;

  const Input({
    super.key,
    required this.title,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        TextField(
          decoration: InputDecoration(
            hintText: label,
            border: OutlineInputBorder(),
            suffixIcon: Icon(icon, color: Colors.grey),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 2),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }
}
