import 'package:dzevent/data/models/event_model.dart';
import 'package:dzevent/lib/styles.dart';
import 'package:dzevent/logic/cubits/events/events_cubit.dart';
import 'package:dzevent/logic/cubits/events/events_state.dart';
import 'package:dzevent/presentation/widgets/profile_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:dzevent/l10n/app_localizations.dart';

class EventFeed extends StatefulWidget {
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
    final drawerItemsUp = [
      {'label': "Feed", 'icon': Icons.home},
      {'label': "My events", 'icon': Icons.calendar_month},
      {'label': "Notifications", 'icon': Icons.notifications},
      {'label': "Followed Associatinons", 'icon': Icons.group},
    ];
    final drawerItemsBottom = [
      {'label': "Settings", 'icon': Icons.settings},
      {'label': "Log Out", 'icon': Icons.logout},
    ];

    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(child: ProfileHeader()),
            for (final item in drawerItemsUp)
              InkWell(
                onTap: () {},
                hoverColor: Colors.grey.shade200,
                child: ListTile(
                  title: Text(item['label'] as String),
                  leading: Icon(item['icon'] as IconData),
                ),
              ),
            Spacer(),
            Divider(),
            for (final item in drawerItemsBottom)
              InkWell(
                onTap: () {},
                hoverColor: Colors.grey.shade200,
                child: ListTile(
                  title: Text(item['label'] as String),
                  leading: Icon(item['icon'] as IconData),
                ),
              ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          spacing: 16.0,
          children: [
            Row(
              children: [
                Builder(
                  builder: (context) => IconButton(
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                    icon: Icon(Icons.list),
                  ),
                ),
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
                colors: [Colors.black.withOpacity(0.6), Colors.transparent],
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
