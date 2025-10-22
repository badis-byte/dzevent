import 'package:flutter/material.dart';

// For large, prominent headings.
const TextStyle headingStyle = TextStyle(
  fontSize: 24.0,
  fontWeight: FontWeight.bold,
  color: Colors.black87,
  letterSpacing: 0.5,
);

// For subtitles or section titles.
const TextStyle subtitleStyle = TextStyle(
  fontSize: 18.0,
  fontWeight: FontWeight.w600,
  color: Colors.black54,
);

// For standard body or paragraph text.
const TextStyle bodyTextStyle = TextStyle(
  fontSize: 16.0,
  fontWeight: FontWeight.normal,
  color: Colors.black87,
  height: 1.5, // Defines the space between lines
);

// For smaller, less important text like captions or metadata.
const TextStyle captionStyle = TextStyle(
  fontSize: 12.0,
  fontWeight: FontWeight.w400,
  color: Colors.grey,
);

// For text inside buttons.
const TextStyle buttonTextStyle = TextStyle(
  fontSize: 16.0,
  fontWeight: FontWeight.bold,
  letterSpacing: 1.0,
);

InputDecoration getInputDecoration({required String hint}) {
  return InputDecoration(
    contentPadding: EdgeInsets.all(8),
    border: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey.shade100),
    ),
    hintText: hint,
  );
}

ButtonStyle getPrimaryBtnStyle({
  required BuildContext context,
  double? raduis,
}) {
  return ElevatedButton.styleFrom(
    backgroundColor: Theme.of(context).primaryColorLight,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(raduis ?? 10.0),
    ),
  );
}
