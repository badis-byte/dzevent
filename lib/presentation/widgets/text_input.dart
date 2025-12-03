import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final int maximumLength;
  final String label;
  final bool expand;

  const TextInput({
    super.key,
    required this.maximumLength,
    required this.label,
    required this.expand,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: Colors.black,
      maxLength: maximumLength,
      maxLines: null,
      expands: expand,
      textAlignVertical: TextAlignVertical.top, //text starts from top
      decoration: InputDecoration(
        label: Text(label, style: TextStyle(color: Colors.grey)),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        alignLabelWithHint: true,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
