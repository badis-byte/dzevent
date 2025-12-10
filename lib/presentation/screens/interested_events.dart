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
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<bool> init() async {
    final authCubit = context.read<AccountCubit>();
    final authState = authCubit.state;
    if (authState is UserFetched) {
      final userId = authState.user.id;
      print("(InterestedEventsScreen): user fetched ${authState.user.name}");

      final interestsCubit = context.read<InterestsCubit>();
      await interestsCubit.getUserInterestedEvents(userId: userId!);

      return true;
    } else {
      print("(InterestedEventsScreen): user not fetched");
      return false;
    }
  }

  Future<bool> refresh() async {
    return await init();
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      title: const Text("Interested Events"),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              await refresh();
            },
            child: Text("Refresh"),
          ),
          SizedBox(height: 16),

          BlocBuilder<InterestsCubit, InterestsState>(
            builder: (context, state) {
              if (state is InterestsLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is InterestsError) {
                return Center(child: Text("Error: ${state.error}"));
              }

              if (state is InterestedEventsFetched) {
                final intrestedEvents = state.interestedEvents;

                return Expanded(
                  child: ListView.builder(
                    itemCount: intrestedEvents.length,
                    itemBuilder: (context, index) => FeedEventCard(
                      event: intrestedEvents[index],
                      isInterested: true,
                    ),
                  ),
                );
              }
              return Center(
                child: Text("Unexpected state: ${state.runtimeType}"),
              );
            },
          ),
        ],
      ),
    );
  }
}
