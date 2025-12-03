import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final String title;
  final int maximumLength;
  final String label;
  final bool expand;

  const TextInput({
    super.key,
    required this.title,
    required this.maximumLength,
    required this.label,
    required this.expand,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),

          SizedBox(height: 8),

          Expanded(
            child: TextField(
              cursorColor: Colors.black,
              maxLength: maximumLength,
              maxLines: null,
              expands: expand,
              textAlignVertical: TextAlignVertical.top, //text starts from top
              decoration: InputDecoration(
                label: Text(label, style: TextStyle(color: Colors.grey)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                alignLabelWithHint: true,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
