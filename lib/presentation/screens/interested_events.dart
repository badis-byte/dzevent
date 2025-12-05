import 'package:dzevent/data/models/event_model.dart';
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

class InterestedEvents extends StatefulWidget {
  static MaterialPageRoute route() =>
      MaterialPageRoute(builder: (context) => InterestedEvents());
  const InterestedEvents({super.key});

  @override
  State<InterestedEvents> createState() => _InterestedEventsState();
}

class _InterestedEventsState extends State<InterestedEvents> {
  Future<List<EventModel>>? _eventsFuture; // <-- FIXED: Cache the future

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    final authCubit = context.read<AccountCubit>();
    await authCubit.getUserData();

    final authState = authCubit.state;
    if (authState is UserFetched) {
      final userId = authState.user.id;
      print("Interested Events: user fetched ${authState.user.name}");

      final interestsCubit = context.read<InterestsCubit>();
      await interestsCubit.getUserInterests(userId: userId);
    } else {
      print("Interested Events: user not fetched");
    }
  }

  Future<List<EventModel>> fetchEvents(List<String> eventsIds) async {
    final events = <EventModel>[];
    final eventsCubit = context.read<EventsCubit>();

    for (final eventId in eventsIds) {
      await eventsCubit.getEvent(id: eventId);

      final state = eventsCubit.state;
      if (state is SingleEventFetched) {
        events.add(state.event);
      } else if (state is EventsError) {
        print("Failed to fetch event $eventId: ${state.error}");
      }
    }
    return events;
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      title: const Text("Interested Events"),
      body: BlocBuilder<InterestsCubit, InterestsState>(
        builder: (context, state) {
          if (state is InterestsLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is InterestsError) {
            return Center(child: Text("Error: ${state.error}"));
          }

          if (state is InterestsFetched) {
            final eventsIds = state.interests
                .map((interest) => interest.eventId)
                .toList();

            /// Only create the future once
            _eventsFuture ??= fetchEvents(eventsIds);

            return FutureBuilder<List<EventModel>>(
              future: _eventsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text('No interested events found'),
                  );
                }

                final events = snapshot.data!;

                return ListView.builder(
                  itemCount: events.length, // <-- FIXED
                  itemBuilder: (context, index) =>
                      FeedEventCard(event: events[index], isInterested: true),
                );
              },
            );
          }

          return Center(child: Text("Unexpected state: ${state.runtimeType}"));
        },
      ),
    );
  }
}
