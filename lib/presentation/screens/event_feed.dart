import 'package:dzevent/lib/styles.dart';
import 'package:dzevent/logic/cubits/auth/auth_cubit.dart';
import 'package:dzevent/logic/cubits/events/events_cubit.dart';
import 'package:dzevent/logic/cubits/events/events_state.dart';
import 'package:dzevent/presentation/screens/event_details.dart';
import 'package:dzevent/presentation/widgets/feed_event_card.dart';
import 'package:dzevent/presentation/widgets/main_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dzevent/l10n/app_localizations.dart';

class EventFeed extends StatefulWidget {
  static MaterialPageRoute route() =>
      MaterialPageRoute(builder: (context) => EventFeed());
  static const String pageRoute = "event-feed";

  const EventFeed({super.key});

  @override
  State<EventFeed> createState() => _EventFeedState();
}

class _EventFeedState extends State<EventFeed> {
  final filters = ["All", "Music", "Sports", "Arts", "Tech"];

  @override
  void initState() {
    context.read<EventsCubit>().getAll();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return MainScaffold(
      title: Text(
        loc.upcomingEvents,
        textAlign: TextAlign.center,
        style: headingStyle,
      ),
      actions: [
        IconButton(onPressed: () {}, icon: Icon(Icons.notifications_none)),
      ],

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          spacing: 16.0,
          children: [
            SearchAnchor.bar(
              suggestionsBuilder: (context, controller) => [],
              barHintText: loc.searchBarHint,
            ),
            Filters(
              filters: [
                loc.filterAll,
                loc.filterMusic,
                loc.filterSports,
                loc.filterArts,
                loc.filterTech,
              ],
            ),
            BlocBuilder<EventsCubit, EventsState>(
              builder: (context, state) {
                if (state is EventsLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is EventsError) {
                  return Center(child: Text(loc.errorOccurred(state.error)));
                }
                if (state is EventsFetched) {
                  final events = state.events;
                  if (events.isEmpty) {
                    return Text("No events found");
                  }
                  return Expanded(
                    child: ListView.builder(
                      itemCount: events.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        EventDetails(event: events[index]),
                                  ),
                                );
                              },
                              child: FeedEventCard(event: events[index]),
                            ),
                            const SizedBox(height: 16),
                          ],
                        );
                      },
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
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          for (final filter in filters)
            OutlinedButton(onPressed: () {}, child: Text(filter)),
        ],
      ),
    );
  }
}
