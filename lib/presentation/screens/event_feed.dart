import 'package:dzevent/data/models/assoc_model.dart';
import 'package:dzevent/data/models/event_model.dart';
import 'package:dzevent/lib/styles.dart';
import 'package:dzevent/logic/cubits/auth/auth_cubit.dart';
import 'package:dzevent/logic/cubits/auth/auth_states.dart';
import 'package:dzevent/logic/cubits/events/events_cubit.dart';
import 'package:dzevent/logic/cubits/events/events_state.dart';
import 'package:dzevent/logic/cubits/interests/interests_cubit.dart';
import 'package:dzevent/logic/cubits/interests/interests_state.dart';
import 'package:dzevent/presentation/screens/associationProfileTwo.dart';
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
  int userId = 2;
  @override
  void initState() {
    context.read<EventsCubit>().getAll();
    super.initState();
    init();
  }

  Future<bool> init() async {
    final authCubit = context.read<AccountCubit>();
    final authState = authCubit.state;
    print("(EventFeed::init) authState= ${authState.runtimeType}");
    if (authState is UserFetched) {
      userId = authState.user.id!;
      print("EventCard: user fetched ${authState.user.name} ");
      final interestsCubit = context.read<InterestsCubit>();
      print(
        "(EventFeed::init) interestsState= ${interestsCubit.state.runtimeType}",
      );
      await interestsCubit.getUserInterests(userId: userId!);
      return true;
    } else if (authState is AssociationFetched) {
      userId = authState.association.id!;
      print("EventCard: user fetched ${authState.association.name} ");
      final interestsCubit = context.read<InterestsCubit>();
      print(
        "(EventFeed::init) interestsState= ${interestsCubit.state.runtimeType}",
      );
      await interestsCubit.getUserInterests(userId: userId!);
      return true;
    } else {
      print(authState);
      print("Event Card: user not fetched");
      return false;
    }
  }

  Future<bool> refresh() async {
    return await init();
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

      body: Container(
        color: Color.fromARGB(255, 240, 242, 245),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            spacing: 16.0,
            children: [
              SearchBarTheme(
                data: SearchBarThemeData(
                  backgroundColor: WidgetStateProperty.all(Colors.blue.shade50),
                  elevation: WidgetStateProperty.all(1),
                  shadowColor: WidgetStateProperty.all(Colors.black12),
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  side: WidgetStateProperty.all(
                    BorderSide(color: Colors.blue.shade200),
                  ),
                  hintStyle: WidgetStateProperty.all(
                    TextStyle(color: Colors.grey.shade500),
                  ),
                  textStyle: WidgetStateProperty.all(
                    TextStyle(color: Colors.black87),
                  ),
                ),
                child: SearchAnchor.bar(
                  suggestionsBuilder: (context, controller) => [],
                  barHintText: loc.searchBarHint,
                ),
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
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  await refresh();
                },
                child: Text("Refresh"),
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

                        if (state is InterestsFetched) {
                          final interests = state.interests;
                          interested = Map.fromEntries(
                            events.map(
                              (event) => MapEntry(
                                event,
                                interests.any((i) => i.eventId == event.id),
                              ),
                            ),
                          );
                        }

                        return Expanded(
                          child: ListView.builder(
                            itemCount: events.length,
                            itemBuilder: (context, index) {
                              final event = events[index];

                              return Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      context.read<AccountCubit>().getAssoc(
                                        event.associationId,
                                      );
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) =>
                                              EventDetails(event: event),
                                        ),
                                      ).then((_) async {
                                        // Refresh when coming back
                                        context.read<EventsCubit>().getAll();
                                        await context
                                            .read<AccountCubit>()
                                            .getcurrentAssociation(userId);
                                      });
                                    },
                                    child: FeedEventCard(
                                      event: event,
                                      isInterested: interested[event]!,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                ],
                              );
                            },
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
        children: [
          for (final filter in filters)
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.blue.shade50,
                  foregroundColor: Colors.blue.shade800,
                  side: BorderSide(color: Colors.blue.shade200),
                  padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () async {
                  if (filter == "All") {
                    context.read<EventsCubit>().getAll();
                  } else {
                    await context.read<EventsCubit>().getEventByType(
                      filter: filter,
                    );
                  }
                },
                child: Text(filter),
              ),
            ),
        ],
      ),
    );
  }
}
