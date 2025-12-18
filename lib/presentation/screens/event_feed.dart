import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:dzevent/data/models/event_model.dart';
import 'package:dzevent/lib/styles.dart';
import 'package:dzevent/logic/cubits/auth/auth_cubit.dart';
import 'package:dzevent/logic/cubits/auth/auth_states.dart';
import 'package:dzevent/logic/cubits/events/events_cubit.dart';
import 'package:dzevent/logic/cubits/events/events_state.dart';
import 'package:dzevent/logic/cubits/interests/interests_cubit.dart';
import 'package:dzevent/logic/cubits/interests/interests_state.dart';
import 'package:dzevent/presentation/screens/event_details.dart';
import 'package:dzevent/presentation/screens/notifications.dart';
import 'package:dzevent/presentation/widgets/feed_event_card.dart';
import 'package:dzevent/presentation/widgets/main_scaffold.dart';
import 'package:dzevent/presentation/widgets/refreshable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dzevent/l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EventFeed extends StatefulWidget {
  static MaterialPageRoute route() =>
      MaterialPageRoute(builder: (context) => EventFeed());
  static const String pageRoute = "event-feed";

  const EventFeed({super.key});

  @override
  State<EventFeed> createState() => _EventFeedState();
}

class _EventFeedState extends State<EventFeed>
    with SingleTickerProviderStateMixin {
  final filters = [
    "Tech",
    "AI and Data Science",
    "Business",
    "Agriculture",
    "Sociology",
    "Meetup",
  ];
  final searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  int userId = 2;
  bool asso = false;

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    final eventsCubit = context.read<EventsCubit>();
    eventsCubit.getAll();
    super.initState();
    searchController.addListener(() async {
      await eventsCubit.searchEvents(searchStr: searchController.text);
    });
    init();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _searchFocusNode.dispose();
    _animationController.dispose();
    super.dispose();
  }

  Future<bool> init() async {
    final authCubit = context.read<AccountCubit>();
    final authState = authCubit.state;

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int _id = prefs.getInt("id") ?? -1;
    bool? isAssoc = prefs.getBool("isAssoc");
    userId = _id;
    if (isAssoc != null) {
      print("user id is $_id");
      print("is Assoc $isAssoc");
      if (isAssoc && authState is! AssociationFetched) {
        print("getting association after sharedPref");
        authCubit.getAssoc(_id);
      } else if (authState is! UserFetched) {
        authCubit.getcurrentUser(_id);
      }
    }
    if (authState is! UserFetched && authState is! AssociationFetched) {
      print("User / Association not fetched");
      return false;
    }
    if (isAssoc != null && !isAssoc && _id > 0) {
      userId = _id;
      final interestsCubit = context.read<InterestsCubit>();
      await interestsCubit.getUserInterests(userId: userId);
      return true;
    } else if (isAssoc != null && !isAssoc && _id > 0) {
      userId = _id;
      asso = true;
      // print("EventCard: user fetched ${authState.association.name} ");
      final interestsCubit = context.read<InterestsCubit>();
      await interestsCubit.getUserInterests(userId: userId);
      return true;
    }
    return false;
  }

  Future<bool> refresh() async {
    print("Refreshing ...");
    return await init();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return MainScaffold(
      title: Text(
        loc.upcomingEvents,
        textAlign: TextAlign.center,
        style: headingStyle.copyWith(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.3,
        ),
      ),
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 8),
          decoration: BoxDecoration(
            color: const Color(0xFF667EEA).withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => NotificationsPage()),
              );
            },
            icon: const Icon(
              Icons.notifications_none_rounded,
              color: Color(0xFF667EEA),
              size: 24,
            ),
          ),
        ),
      ],
      body: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [const Color(0xFFF8F9FC), const Color(0xFFFFFFFF)],
            ),
          ),
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Column(
              children: [
                // Search Bar Section
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
                  child: Container(
                    height: 56,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.06),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 16),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xFF667EEA).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.search_rounded,
                            color: Color(0xFF667EEA),
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextFormField(
                            controller: searchController,
                            focusNode: _searchFocusNode,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF2D3748),
                            ),
                            decoration: InputDecoration(
                              hintText: "Search for events",
                              hintStyle: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 16,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 5),

                // Filters Section
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Filters(
                    filters: [
                      "Tech",
                      "AI and Data Science",
                      "Business",
                      "Agriculture",
                      "Sociology",
                      "Meetup",
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Events List
                Expanded(
                  child: BlocBuilder<EventsCubit, EventsState>(
                    builder: (context, state) {
                      if (state is EventsLoading) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.primaryContainer,
                                  shape: BoxShape.circle,
                                ),
                                child: CircularProgressIndicator(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                "Loading events...",
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      if (state is EventsError) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  color: const Color(
                                    0xFFFF6B6B,
                                  ).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Icon(
                                  Icons.error_outline_rounded,
                                  color: Color(0xFFFF6B6B),
                                  size: 40,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                loc.errorOccurred(state.error),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      if (state is EventsFetched) {
                        final events = state.events;
                        if (events.isEmpty) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  child: Icon(
                                    Icons.event_busy_rounded,
                                    size: 48,
                                    color: Colors.grey[400],
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  "No events found",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey[700],
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  "Try adjusting your filters",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[500],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }

                        return BlocConsumer<InterestsCubit, InterestsState>(
                          listener: (context, state) async {
                            final authCubit = context.read<AccountCubit>();
                            final authState = authCubit.state;
                            if (state is InterestsMutated) {
                              if (authState is UserFetched) {
                                await context
                                    .read<InterestsCubit>()
                                    .getUserInterests(
                                      userId: authState.user.id!,
                                    );
                              } else {
                                debugPrint(
                                  "User not fetched. Cannot refetch feed",
                                );
                              }
                            }
                          },
                          builder: (context, state) {
                            print("Interests State ${state.runtimeType}");
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

                            return Refreshable(
                              refresh: refresh,
                              child: ListView.builder(
                                physics: const AlwaysScrollableScrollPhysics(),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 8,
                                ),
                                itemCount: events.length,
                                itemBuilder: (context, index) {
                                  final event = events[index];

                                  return BlocBuilder<
                                    AccountCubit,
                                    AccountState
                                  >(
                                    builder: (context, state) {
                                      if (state is! AccountGuest) {
                                        print("state is : ${state.toString()}");
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                            bottom: 16,
                                          ),
                                          child: GestureDetector(
                                            onTap: () {
                                              context
                                                  .read<AccountCubit>()
                                                  .getAssoc(
                                                    event.associationId,
                                                  );
                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (_) => EventDetails(
                                                    event: event,
                                                  ),
                                                ),
                                              );
                                            },
                                            child: FeedEventCard(
                                              event: event,
                                              isInterested: interested[event]!,
                                            ),
                                          ),
                                        );
                                      }
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                          bottom: 16,
                                        ),
                                        child: GestureDetector(
                                          onTap: () {},
                                          child: FeedEventCard(
                                            event: event,
                                            isInterested: interested[event]!,
                                          ),
                                        ),
                                      );
                                    },
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Filters extends StatefulWidget {
  final List<String> filters;
  const Filters({super.key, required this.filters});

  @override
  State<Filters> createState() => _FiltersState();
}

class _FiltersState extends State<Filters> {
  late Map<String, bool> filtersState;

  @override
  void initState() {
    super.initState();
    filtersState = Map.fromEntries(
      widget.filters.map((filter) => MapEntry(filter, false)),
    );
  }

  Future<bool> toggleFilter(String filter) async {
    final prevState = filtersState[filter]!;
    setState(() {
      filtersState = {...filtersState, filter: !prevState};
    });
    await context.read<EventsCubit>().getFilteredEvents(
      filters: filtersState.entries
          .where((entry) => entry.value)
          .map((entry) => entry.key)
          .toList(),
    );
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.filters.length,
        itemBuilder: (context, index) {
          final filter = widget.filters[index];
          final isActive = filtersState[filter]!;

          return Padding(
            padding: EdgeInsets.only(
              right: index < widget.filters.length - 1 ? 10 : 0,
            ),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () async {
                    await toggleFilter(filter);
                  },
                  borderRadius: BorderRadius.circular(24),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      gradient: isActive
                          ? const LinearGradient(
                              colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
                            )
                          : null,
                      color: isActive ? null : Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: isActive
                            ? Colors.transparent
                            : const Color(0xFFE8ECF4),
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: isActive
                              ? const Color(0xFF667EEA).withOpacity(0.3)
                              : Colors.black.withOpacity(0.04),
                          blurRadius: isActive ? 12 : 8,
                          offset: Offset(0, isActive ? 4 : 2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (isActive) ...[
                          const Icon(
                            Icons.check_circle_rounded,
                            size: 16,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 6),
                        ],
                        Text(
                          filter,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: isActive
                                ? Colors.white
                                : const Color(0xFF2D3748),
                            letterSpacing: 0.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
