import 'package:dzevent/logic/cubits/events/events_cubit.dart';
import 'package:dzevent/logic/cubits/events/events_state.dart';
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
  @override
  void initState() {
    super.initState();
    context.read<EventsCubit>().getAll();
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      title: Text("Interested Events"),
      body: BlocBuilder<EventsCubit, EventsState>(
        builder: (context, state) {
          if (state is EventsLoading) {
            return CircularProgressIndicator();
          }
          if (state is EventsFetched) {
            final events = state.events;
            return ListView.builder(
              itemCount: events.length,
              itemBuilder: (context, index) =>
                  FeedEventCard(event: events[index], isInterested: false),
            );
          }
          return Text("Unexpected state ${state.runtimeType}");
        },
      ),
    );
  }
}
