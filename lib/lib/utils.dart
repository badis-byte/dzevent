import 'package:flutter/material.dart';

TimeOfDay parseTimeOfDay({required String str}) {
  final splits = str.split(":");
  return TimeOfDay(hour: int.parse(splits[0]), minute: int.parse(splits[1]));
}

String? Function(String?) getIsRequiredValidator({required bool isRequired}) {
  return (value) {
    if (isRequired && (value == null || value.isEmpty)) {
      return "This field cannot be empty";
    }
    return null;
  };
}
