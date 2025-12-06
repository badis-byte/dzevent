import 'package:dzevent/data/models/event_model.dart';
import 'package:dzevent/logic/cubits/auth/auth_cubit.dart';
import 'package:dzevent/logic/cubits/auth/auth_states.dart';
import 'package:dzevent/logic/cubits/interests/interests_cubit.dart';
import 'package:dzevent/logic/cubits/interests/interests_state.dart';
import 'package:dzevent/presentation/widgets/feed_event_card.dart';
import 'package:dzevent/presentation/widgets/main_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InterestedEventsScreen extends StatefulWidget {
  static MaterialPageRoute route() =>
      MaterialPageRoute(builder: (context) => InterestedEventsScreen());
  const InterestedEventsScreen({super.key});

  @override
  State<InterestedEventsScreen> createState() => _InterestedEventsScreenState();
}

class _InterestedEventsScreenState extends State<InterestedEventsScreen> {
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
      print("(InterestedEventsScreen): user fetched ${authState.user.name}");

      final interestsCubit = context.read<InterestsCubit>();
      await interestsCubit.getUserInterestedEvents(userId: userId);
    } else {
      print("(InterestedEventsScreen): user not fetched");
    }
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

          if (state is InterestedEventsFetched) {
            final intrestedEvents = state.interestedEvents;

            return ListView.builder(
              itemCount: intrestedEvents.length, // <-- FIXED
              itemBuilder: (context, index) => FeedEventCard(
                event: intrestedEvents[index],
                isInterested: true,
              ),
            );
          }
          ;
          return Center(child: Text("Unexpected state: ${state.runtimeType}"));
        },
      ),
    );
  }
}
