import 'package:dzevent/data/models/assoc_model.dart';
import 'package:dzevent/data/models/event_model.dart';
import 'package:dzevent/logic/cubits/auth/auth_cubit.dart';
import 'package:dzevent/logic/cubits/events/events_cubit.dart';
import 'package:dzevent/logic/cubits/events/events_state.dart';
import 'package:dzevent/presentation/screens/add_event.dart';
import 'package:dzevent/l10n/app_localizations.dart';
import 'package:dzevent/presentation/screens/event_feed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

class _AssocProfTwoState extends State<AssocProfTwo> {
  AssociationModel? _currentAssoc;
  @override
  void initState() {
    super.initState();
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
      profilePicture:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRBzkx9EjnTvs28LpVsnDW72jM0jNN-D4wOvw&s",
      bio: "meta",
      createdAt: DateTime(2000),
      isVerified: true,
    );
    debugPrint(_currentAssoc?.id.toString() ?? "no id");
    context.read<EventsCubit>().getAllEventsByUser(_currentAssoc!.id!);
  }

  var logo =
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR0NfsQx_-GICZJcadqDeNBMvwzq-RInkcOzg&s";

  Widget getStatCard(String title, String subTitle) {
    return Container(
      width: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey[100],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              subTitle,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget headerOfPage(AssociationModel assos) {
    final loc = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: CircleAvatar(
            radius: 64,
            child: ClipOval(
              child: Image.network(
                assos.profilePicture,
                width: 128,
                height: 128,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.person, size: 64);
                },
              ),
            ),
          ),
        ),
        Text(
          assos.name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        Text(
          assos.bio,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            getStatCard("1.2K", loc.subscribers),
            SizedBox(width: 8),
            BlocBuilder<EventsCubit, EventsState>(
              builder: (context, state) {
                if (state is EventsFetched) {
                  return getStatCard(
                    state.events.length.toString(),
                    loc.eventsCount,
                  );
                }
                return Text("no data fetched");
              },
            ),
            SizedBox(width: 8),
            // getStatCard("5.8K", loc.interested),   //i dont think we need this with association
          ],
        ),
      ],
    );
  }

  Widget eventCard(EventModel event) {
    final loc = AppLocalizations.of(context)!;

    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
            child: Card(
              color: Colors.white,
              elevation: 1,
              child: Row(
                children: [
                  Image(
                    image: NetworkImage(event.imageUrl),
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(Icons.event, size: 48);
                    },
                  ),
                  SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        event.title,
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        event.startDatetime.toString(),
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.blueAccent,
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.people_outline, color: Colors.grey),
                          SizedBox(width: 2),
                          Text(
                            loc.interestedCount(100), //dynamic
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  PopupMenuButton<String>(
                    color: Colors.white,
                    onSelected: (value) {
                      // Handle option selected
                      if (value == 'edit') {
                        print("Edit clicked");
                      } else if (value == 'delete') {
                        print("Delete clicked");
                      }
                    },
                    itemBuilder: (BuildContext context) => [
                      PopupMenuItem(
                        value: 'edit',
                        child: const Text('Edit'),
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
                        child: Text('Delete'),
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
                    icon: const Icon(Icons.more_vert),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    // late final Map<_FormField, TextEditingController> controllers;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                debugPrint("routing to eventfeed");
                Navigator.pop(context);
              },
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            headerOfPage(_currentAssoc!),
            SizedBox(height: 32),
            // title
            SizedBox(
              width: double.infinity,
              child: Text(
                loc.eventsTitle,
                textAlign: TextAlign.start,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),
            _currentAssoc == null
                ? BlocBuilder<EventsCubit, EventsState>(
                    builder: (context, state) {
                      if (state is EventsLoading) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (state is EventsError) {
                        return Center(child: Text(state.error));
                      }
                      if (state is EventsFetched) {
                        debugPrint(state.events.toString());
                        return Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(
                              children: [
                                for (final event in state.events)
                                  eventCard(event),
                              ],
                            ),
                          ),
                        );
                      }
                      return Text("Unexpected state: ${state.runtimeType}");
                    },
                  )
                : BlocBuilder<EventsCubit, EventsState>(
                    builder: (context, state) {
                      if (state is EventsLoading) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (state is EventsError) {
                        return Center(child: Text(state.error));
                      }
                      if (state is EventsFetched) {
                        debugPrint(state.events.toString());
                        return Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(
                              children: [
                                for (final event in state.events)
                                  eventCard(event),
                              ],
                            ),
                          ),
                        );
                      } else {
                        debugPrint("no event fetched");
                      }
                      return Text("Unexpected state: ${state.runtimeType}");
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
