import 'package:dzevent/data/models/assoc_model.dart';
import 'package:dzevent/data/models/event_model.dart';
import 'package:dzevent/logic/cubits/auth/auth_cubit.dart';
import 'package:dzevent/logic/cubits/events/events_cubit.dart';
import 'package:dzevent/logic/cubits/events/events_state.dart';
import 'package:dzevent/logic/cubits/followers/followers_cubits.dart';
import 'package:dzevent/presentation/screens/add_event.dart';
import 'package:dzevent/l10n/app_localizations.dart';
import 'package:dzevent/presentation/screens/event_feed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

void main(List<String> args) {
  runApp(const AssocProfTwo());
}

class AssocProfTwo extends StatefulWidget {
  static MaterialPageRoute route() =>
      MaterialPageRoute(builder: (context) => AssocProfTwo());
  const AssocProfTwo({super.key});

  @override
  State<AssocProfTwo> createState() => _AssocProfTwoState();
}

class _AssocProfTwoState extends State<AssocProfTwo> with TickerProviderStateMixin {
  AssociationModel? _currentAssoc;
  late AnimationController _headerAnimController;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    
    _headerAnimController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    )..forward();

    _fadeController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    )..forward();

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeIn),
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _fadeController, curve: Curves.easeOut));

    //store current user
    //fetch events
    final state = context.read<AccountCubit>().association;
    if (state == true) {
      final assoc = context.read<AccountCubit>().currentAssociation;
      _currentAssoc = assoc;
    }

    _currentAssoc ??= AssociationModel(
      id: 2,
      name: "Meta",
      email: "Meta@gmail.com",
      password: "pass",
      profilePicture:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRBzkx9EjnTvs28LpVsnDW72jM0jNN-D4wOvw&s",
      bio: "meta",
      createdAt: DateTime(2000),
      isVerified: true,
    );
    debugPrint(_currentAssoc?.id.toString() ?? "no id");
    context.read<EventsCubit>().getAllEventsByUser(_currentAssoc!.id!);
  }

  @override
  void dispose() {
    _headerAnimController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  var logo =
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR0NfsQx_-GICZJcadqDeNBMvwzq-RInkcOzg&s";

  Widget getStatCard(String title, String subTitle) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).colorScheme.primaryContainer,
            Theme.of(context).colorScheme.primaryContainer.withOpacity(0.7),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.15),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          SizedBox(height: 4),
          Text(
            subTitle,
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget headerOfPage(AssociationModel assos) {
    final loc = AppLocalizations.of(context)!;

    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Theme.of(context).colorScheme.primary.withOpacity(0.1),
            Theme.of(context).scaffoldBackgroundColor,
          ],
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ScaleTransition(
            scale: Tween<double>(begin: 0.5, end: 1.0).animate(
              CurvedAnimation(
                parent: _headerAnimController,
                curve: Curves.elasticOut,
              ),
            ),
            child: Hero(
              tag: 'assoc_profile_${assos.id}',
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                      blurRadius: 15,
                      spreadRadius: 3,
                    ),
                  ],
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primary,
                    width: 3,
                  ),
                ),
                child: CircleAvatar(
                  radius: 48,
                  backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                  child: ClipOval(
                    child: Image.network(
                      assos.profilePicture,
                      width: 96,
                      height: 96,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(
                          Icons.account_balance,
                          size: 48,
                          color: Theme.of(context).colorScheme.primary,
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 12),
          FadeTransition(
            opacity: _fadeAnimation,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      assos.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    if (assos.isVerified) ...[
                      SizedBox(width: 6),
                      Container(
                        padding: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.check,
                          size: 14,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ],
                ),
                SizedBox(height: 6),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceContainer,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    assos.bio,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          SlideTransition(
            position: _slideAnimation,
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: 
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
          Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder(
              future: context.read<FollowCubit>().getFollowers(_currentAssoc!.id!),   // The future you want to wait for
              initialData: null,              // Optional: data to show before the future completes
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();  // loading state
                }

                if (snapshot.hasError) {
                  return Text("N/A");
                }

                if (snapshot.hasData) {
                  return getStatCard("${snapshot.data}", loc.subscribers);              
                }

                return Text("N/A");
              },
            ),
                  SizedBox(width: 12),
                  BlocBuilder<EventsCubit, EventsState>(
                    builder: (context, state) {
                      if (state is EventsFetched) {
                        return getStatCard(
                          state.events.length.toString(),
                          loc.eventsCount,
                        );
                      }
                      return getStatCard("...", loc.eventsCount);
                    },
                  ),
                ],
              ),],
            ),
            ),
          ),
        ],
      ),
    );
  }

  Widget eventCard(EventModel event) {
    final loc = AppLocalizations.of(context)!;

    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.1),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Image Section
            Stack(
              children: [
                Container(
                  width: 140,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                  ),
                  child: Image(
                    image: NetworkImage(event.imageUrl),
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        child: Icon(
                          Icons.event,
                          size: 48,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      );
                    },
                  ),
                ),
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: Text(
                      DateFormat("MMM dd").format(event.startDatetime),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // Content Section
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          event.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(
                              Icons.access_time,
                              size: 16,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                DateFormat("EEE, MMM d • h:mm a").format(event.startDatetime),
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondaryContainer,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.people_outline,
                                size: 16,
                                color: Theme.of(context).colorScheme.onSecondaryContainer,
                              ),
                              SizedBox(width: 4),
                              Text(
                                loc.interestedCount(100),
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // Menu Button
            Container(
              padding: EdgeInsets.only(right: 8),
              child: PopupMenuButton<String>(
                color: Theme.of(context).colorScheme.surface,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                offset: Offset(-10, 10),
                elevation: 8,
                onSelected: (value) {
                  if (value == 'edit') {
                    print("Edit clicked");
                  } else if (value == 'delete') {
                    print("Delete clicked");
                  }
                },
                itemBuilder: (BuildContext context) => [
                  PopupMenuItem(
                    value: 'edit',
                    child: Row(
                      children: [
                        Icon(
                          Icons.edit_outlined,
                          size: 20,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        SizedBox(width: 12),
                        Text(
                          'Edit',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Addevent(event: event),
                        ),
                      );
                    },
                  ),
                  PopupMenuItem(
                    value: 'delete',
                    child: Row(
                      children: [
                        Icon(
                          Icons.delete_outline,
                          size: 20,
                          color: Theme.of(context).colorScheme.error,
                        ),
                        SizedBox(width: 12),
                        Text(
                          'Delete',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).colorScheme.error,
                          ),
                        ),
                      ],
                    ),
                    onTap: () async {
                      final cubit = context.read<EventsCubit>();
                      try {
                        if (await cubit.deleteInstace(event.id)) {
                          cubit.getAllEventsByUser(_currentAssoc!.id!);
                          print("Event deleted successfully");
                        }
                      } catch (e) {
                        print("Error deleting event: $e");
                      }
                    },
                  ),
                ],
                icon: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.more_vert,
                    size: 20,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Container(
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
              ),
            ],
          ),
          child: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () async {
              debugPrint("routing to eventfeed");
              await context.read<EventsCubit>().getAll();
              Navigator.pop(context);
            },
          ),
        ),
        actions: [
          Container(
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                ),
              ],
            ),
            child: IconButton(
              icon: Icon(Icons.settings_outlined),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              headerOfPage(_currentAssoc!),
              SizedBox(height: 32),
              // Section Header
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.event_note,
                      size: 24,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  SizedBox(width: 12),
                  Text(
                    loc.eventsTitle,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              _currentAssoc == null
                  ? BlocBuilder<EventsCubit, EventsState>(
                      builder: (context, state) {
                        if (state is EventsLoading) {
                          return Expanded(
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircularProgressIndicator(),
                                  SizedBox(height: 16),
                                  Text(
                                    "Loading events...",
                                    style: TextStyle(
                                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                        if (state is EventsError) {
                          return Expanded(
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.error_outline,
                                    size: 64,
                                    color: Theme.of(context).colorScheme.error,
                                  ),
                                  SizedBox(height: 16),
                                  Text(
                                    state.error,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                        if (state is EventsFetched) {
                          debugPrint(state.events.toString());
                          if (state.events.isEmpty) {
                            return Expanded(
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.event_busy,
                                      size: 64,
                                      color: Theme.of(context).colorScheme.outline,
                                    ),
                                    SizedBox(height: 16),
                                    Text(
                                      "No events yet",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: Theme.of(context).colorScheme.onSurface,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                          return Expanded(
                            child: ListView.builder(
                              itemCount: state.events.length,
                              itemBuilder: (context, index) {
                                return AnimatedOpacity(
                                  opacity: 1.0,
                                  duration: Duration(milliseconds: 300 + (index * 100)),
                                  child: eventCard(state.events[index]),
                                );
                              },
                            ),
                          );
                        }
                        return Expanded(
                          child: Center(
                            child: Text("Unexpected state: ${state.runtimeType}"),
                          ),
                        );
                      },
                    )
                  : BlocBuilder<EventsCubit, EventsState>(
                      builder: (context, state) {
                        if (state is EventsLoading) {
                          return Expanded(
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircularProgressIndicator(),
                                  SizedBox(height: 16),
                                  Text(
                                    "Loading events...",
                                    style: TextStyle(
                                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                        if (state is EventsError) {
                          return Expanded(
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.error_outline,
                                    size: 64,
                                    color: Theme.of(context).colorScheme.error,
                                  ),
                                  SizedBox(height: 16),
                                  Text(
                                    state.error,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                        if (state is EventsFetched) {
                          debugPrint(state.events.toString());
                          if (state.events.isEmpty) {
                            return Expanded(
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.event_busy,
                                      size: 64,
                                      color: Theme.of(context).colorScheme.outline,
                                    ),
                                    SizedBox(height: 16),
                                    Text(
                                      "No events yet",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: Theme.of(context).colorScheme.onSurface,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                          return Expanded(
                            child: ListView.builder(
                              itemCount: state.events.length,
                              itemBuilder: (context, index) {
                                return AnimatedOpacity(
                                  opacity: 1.0,
                                  duration: Duration(milliseconds: 300 + (index * 100)),
                                  child: eventCard(state.events[index]),
                                );
                              },
                            ),
                          );
                        } else {
                          debugPrint("no event fetched");
                        }
                        return Expanded(
                          child: Center(
                            child: Text("Unexpected state: ${state.runtimeType}"),
                          ),
                        );
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}