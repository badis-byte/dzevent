import 'package:dzevent/lib/defs.dart';
import 'package:dzevent/lib/styles.dart';
import 'package:dzevent/logic/cubits/events/events_cubit.dart';
import 'package:dzevent/logic/cubits/events/events_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:dzevent/l10n/app_localizations.dart';

class EventFeed extends StatelessWidget {
  static const String pageRoute = "event-feed";
  final filters = ["All", "Music", "Sports", "Arts", "Tech"];

  EventFeed({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

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
                    loc.upcomingEvents,
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
              barHintText: loc.searchBarHint,
            ),
            Filters(filters: [
              loc.filterAll,
              loc.filterMusic,
              loc.filterSports,
              loc.filterArts,
              loc.filterTech,
            ]),
            BlocBuilder<EventsCubit, EventsState>(
              builder: (context, state) {
                if (state is EventsLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is EventsError) {
                  return Center(child: Text(loc.errorOccurred(state.error)));
                }
                if (state is EventsFetched) {
                  final posts = state.posts;
                  return Expanded(
                    child: ListView.builder(
                      itemCount: posts.length,
                      itemBuilder: (context, index) =>
                          Text(loc.oneEvent), // Using localized string
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
  final Event event;
  const EventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

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
                  Colors.black.withOpacity(0.6),
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
                      const SizedBox(height: 8),
                      Text(
                        DateFormat("E, MMM d").add_jm().format(event.datetime),
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
                          label: Text(loc.showInterest),
                          icon: const Icon(Icons.favorite_border),
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
