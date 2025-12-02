import 'package:dzevent/data/models/event_model.dart';
import 'package:dzevent/lib/styles.dart';
import 'package:dzevent/logic/cubits/events/events_cubit.dart';
import 'package:dzevent/logic/cubits/events/events_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class EventFeed extends StatefulWidget {
  static const String pageRoute = "event-feed";

  EventFeed({super.key});

  @override
  State<EventFeed> createState() => _EventFeedState();
}

class _EventFeedState extends State<EventFeed> {
  final filters = ["All", "Music", "Sports", "Arts", "Tech"];

  @override
  void initState() {
    context.read<EventsCubit>().getUserData();
    super.initState();
  }

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
            Filters(filters: filters),
            BlocBuilder<EventsCubit, EventsState>(
              builder: (context, state) {
                if (state is EventsLoading) {
                  return Center(child: CircularProgressIndicator());
                }
                if (state is EventsError) {
                  return Center(child: Text("Error: ${state.error}"));
                }
                if (state is EventsFetched) {
                  final events = state.events;
                  if (events.isEmpty) {
                    return Text("No events found");
                  }
                  return Expanded(
                    child: ListView.builder(
                      itemCount: events.length,
                      itemBuilder: (context, index) =>
                          EventCard(event: events[index]),
                    ),
                  );
                }
                return const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class Filters extends StatelessWidget {
  final List<String> filters;
  const Filters({super.key, required this.filters});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        for (final filter in filters)
          OutlinedButton(onPressed: () {}, child: Text(filter)),
      ],
    );
  }
}

class EventCard extends StatelessWidget {
  static const double _height = 400;
  final EventModel event;
  const EventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: _height,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(event.imageUrl, fit: BoxFit.cover),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withValues(alpha: .6),
                  Colors.transparent,
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
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
                        DateFormat(
                          "E, MMM d\n",
                        ).add_jm().format(event.startDatetime),
                        style: subtitleStyle.copyWith(
                          color: Colors.grey.shade400,
                        ),
                      ),
                      Text(
                        event.location,
                        style: subtitleStyle.copyWith(
                          color: Colors.grey.shade400,
                        ),
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
                          style: getPrimaryBtnStyle(
                            context: context,
                            raduis: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
