import 'package:dzevent/lib/styles.dart';
import 'package:dzevent/screens/home.dart';
import 'package:flutter/material.dart';

class EventFeed extends StatelessWidget {
  static const String pageRoute = "event-feed";
  const EventFeed({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(onPressed: () {}, icon: Icon(Icons.list)),
                Expanded(
                  child: Text(
                    "Upcoming events",
                    textAlign: TextAlign.center,
                    style: headingStyle,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.notifications_none),
                ),
              ],
            ),
            SearchAnchor.bar(
              suggestionsBuilder: (context, controller) => [],
              barHintText: "Search for events ...",
            ),
          ],
        ),
      ),
    );
  }
}
