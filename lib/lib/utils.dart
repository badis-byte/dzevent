import 'package:flutter/material.dart';

TimeOfDay parseTimeOfDay({required String str}) {
  final splits = str.split(":");
  return TimeOfDay(hour: int.parse(splits[0]), minute: int.parse(splits[1]));
}
