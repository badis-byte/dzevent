import 'package:dzevent/data/models/event_model.dart';
import 'package:dzevent/lib/styles.dart';
import 'package:dzevent/logic/cubits/auth/auth_cubit.dart';
import 'package:dzevent/logic/cubits/auth/auth_states.dart';
import 'package:dzevent/logic/cubits/events/events_cubit.dart';
import 'package:dzevent/logic/cubits/events/events_state.dart';
import 'package:dzevent/logic/cubits/interests/interests_cubit.dart';
import 'package:dzevent/logic/cubits/interests/interests_state.dart';
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
    init();
  }

  Future<bool> init() async {
    final authCubit = context.read<AccountCubit>();
    await authCubit.getUserData();
    final authState = authCubit.state;
    if (authState is UserFetched) {
      final userId = authState.user.id;
      print("EventCard: user fetched ${authState.user.name} ");
      final interestsCubit = context.read<InterestsCubit>();
      await interestsCubit.getUserInterests(userId: userId);
      return true;
    } else {
      print("Event Card: user not fetched");
      return false;
    }
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
                  return BlocBuilder<InterestsCubit, InterestsState>(
                    builder: (context, state) {
                      Map<EventModel, bool> interested = Map.fromEntries(
                        events.map((event) => MapEntry(event, false)),
                      );
                      if (state is InterestsLoading) {
                        print("loading interests");
                      }
                      if (state is InterestsError) {
                        print("Failed to fetch interests: ${state.error}");
                      }
                      if (state is InterestsFetched) {
                        print("Interests fetched");
                        final interests = state.interests;
                        interested = Map.fromEntries(
                          events.map(
                            (event) => MapEntry(
                              event,
                              interests.any(
                                (interest) => interest.eventId == event.id,
                              ),
                            ),
                          ),
                        );
                      }
                      return Expanded(
                        child: ListView.builder(
                          itemCount: events.length,
                          itemBuilder: (context, index) => FeedEventCard(
                            event: events[index],
                            isInterested: interested[events[index]]!,
                          ),
                        ),
                      );
                    },
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
