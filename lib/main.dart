import 'package:dzevent/screens/event_feed.dart';
import 'package:dzevent/screens/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {EventFeed.pageRoute: (ctx) => EventFeed()},
      home: Scaffold(body: Home()),
    );
  }
}
