import 'package:dzevent/screens/home.dart';
import 'package:flutter/material.dart';

class EventFeed extends StatelessWidget {
  static const String pageRoute = "event-feed";
  const EventFeed({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sample App")),
      body: Column(children: [HomeBtn()]),
    );
  }
}
