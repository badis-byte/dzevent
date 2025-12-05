import 'package:dzevent/data/models/event_model.dart';
import 'package:dzevent/l10n/app_localizations.dart';
import 'package:dzevent/lib/styles.dart';
import 'package:dzevent/logic/cubits/auth/auth_cubit.dart';
import 'package:dzevent/logic/cubits/auth/auth_states.dart';
import 'package:dzevent/logic/cubits/interests/interests_cubit.dart';
import 'package:dzevent/logic/cubits/interests/interests_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class FeedEventCard extends StatelessWidget {
  static const double _height = 400;
  final EventModel event;
  final bool isInterested;
  const FeedEventCard({
    super.key,
    required this.event,
    required this.isInterested,
  });

  Future<void> toggleInterest(BuildContext context) async {
    final interestsCubit = context.read<InterestsCubit>();
    final authCubit = context.read<AccountCubit>();
    final authState = authCubit.state;
    final interestsState = interestsCubit.state;

    if (authState is! UserFetched) {
      print("User not fetched. Cannot toggle interest");
      return;
    }
    if (interestsState is! InterestsFetched) {
      print("Interest are not fetched. Cannot toogle interest");
      return;
    }

    final toggled = await interestsCubit.toggle(
      userId: authState.user.id,
      eventId: event.id,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(toggled ? "Toggled succefully" : "Failed to toggle"),
        duration: Duration(seconds: 3),
      ),
    );
  }

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
                          onPressed: () async {
                            await toggleInterest(context);
                          },
                          label: Text(loc.showInterest),
                          icon: Icon(
                            isInterested
                                ? Icons.favorite
                                : Icons.favorite_border,
                          ),
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
