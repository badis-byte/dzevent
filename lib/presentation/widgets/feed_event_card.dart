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
      print("Please Login. Cannot toggle interest");
      return;
    }

    /// wait until interests are loaded
    /// assume this is done by ancestors
    if (interestsState is! InterestsCanToggle) {
      print("Interest are not fetched. Cannot toogle interest");
      return;
    }

    final toggled = await interestsCubit.toggle(
      userId: authState.user.id!,
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

    return Container(
      width: double.infinity,
      height: _height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 20,
            offset: const Offset(0, 8),
            spreadRadius: 2,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              event.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[300],
                  child: Icon(
                    Icons.image_not_supported_rounded,
                    size: 60,
                    color: Colors.grey[500],
                  ),
                );
              },
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(0.8),
                    Colors.black.withOpacity(0.4),
                    Colors.transparent,
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  stops: const [0.0, 0.5, 1.0],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Spacer(),
                        Text(
                          event.title,
                          style: headingStyle.copyWith(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.3,
                            shadows: [
                              Shadow(
                                color: Colors.black.withOpacity(0.5),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.3),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.access_time_rounded,
                                size: 16,
                                color: Colors.white,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                DateFormat("E, MMM d\n").add_jm().format(event.startDatetime),
                                style: subtitleStyle.copyWith(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.3),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.location_on_rounded,
                                size: 16,
                                color: Colors.white,
                              ),
                              const SizedBox(width: 6),
                              Flexible(
                                child: Text(
                                  (event.location).split(",")[0].contains("+")? (event.location).split(",").skip(1).join(",") :event.location,
                                  style: subtitleStyle.copyWith(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  BlocBuilder<AccountCubit, AccountState>(
                    builder: (context, state) {
                      if (state is UserFetched) {
                        return Flexible(
                          child: Column(
                            children: [
                              Spacer(),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    gradient: isInterested
                                        ? const LinearGradient(
                                            colors: [
                                              Color(0xFFFF6B9D),
                                              Color(0xFFFFA36C),
                                            ],
                                          )
                                        : null,
                                    color: isInterested ? null : Colors.white.withOpacity(0.95),
                                    boxShadow: [
                                      BoxShadow(
                                        color: isInterested
                                            ? const Color(0xFFFF6B9D).withOpacity(0.4)
                                            : Colors.black.withOpacity(0.15),
                                        blurRadius: 12,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: ElevatedButton.icon(
                                    onPressed: () async {
                                      await toggleInterest(context);
                                    },
                                    label: Text(
                                      loc.showInterest,
                                      style: TextStyle(
                                        color: isInterested
                                            ? Colors.white
                                            : const Color(0xFF667EEA),
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14,
                                      ),
                                    ),
                                    icon: Icon(
                                      isInterested
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: isInterested
                                          ? Colors.white
                                          : const Color(0xFF667EEA),
                                      size: 18,
                                    ),
                                    iconAlignment: IconAlignment.end,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.transparent,
                                      shadowColor: Colors.transparent,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 12,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      return SizedBox();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}