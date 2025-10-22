import 'package:dzevent/lib/styles.dart';
import 'package:dzevent/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Event {
  final String image_url;
  final String title;
  final DateTime datetime;
  final String location;
  const Event({
    required this.image_url,
    required this.title,
    required this.datetime,
    required this.location,
  });
}

class EventFeed extends StatelessWidget {
  static const String pageRoute = "event-feed";
  final events = [
    Event(
      image_url: "assets/images/event_feed/image1.png",
      title: "Indie Music Festival",
      datetime: DateTime(2025, 07, 26, 19),
      location: "New York",
    ),
    Event(
      image_url: "assets/images/event_feed/image2.png",
      title: "City Marathon 2024",
      datetime: DateTime(2025, 07, 27, 9),
      location: "Chicago",
    ),
  ];
  EventFeed({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          spacing: 16.0,
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
            Filters(),
            Expanded(
              child: ListView.builder(
                itemCount: events.length,
                itemBuilder: (context, index) =>
                    EventCard(event: events[index]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Filters extends StatelessWidget {
  final _filters = ["All", "Music", "Sports", "Arts", "Tech"];
  Filters({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        for (final filter in _filters)
          OutlinedButton(onPressed: () {}, child: Text(filter)),
      ],
    );
  }
}

class EventCard extends StatelessWidget {
  static const double _height = 400;
  final Event event;
  const EventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: _height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(event.image_url),
          fit: BoxFit.fill,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Spacer(),
                  Text(
                    event.title,
                    style: headingStyle.copyWith(color: Colors.white),
                  ),
                  SizedBox(height: 8),
                  Text(
                    DateFormat("E, MMM d\n").add_jm().format(event.datetime),
                    style: subtitleStyle.copyWith(color: Colors.grey.shade400),
                  ),
                  Text(
                    event.location,
                    style: subtitleStyle.copyWith(color: Colors.grey.shade400),
                  ),
                ],
              ),
            ),
            Flexible(
              child: Column(
                children: [
                  Spacer(),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      label: Text("Show Interest"),
                      icon: Icon(Icons.favorite_border),
                      iconAlignment: IconAlignment.end,
                      style: getPrimaryBtnStyle(context: context, raduis: 15),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
