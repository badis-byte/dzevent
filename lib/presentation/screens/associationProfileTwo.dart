import 'package:dzevent/data/models/event_model.dart';
import 'package:dzevent/data/models/user_model.dart';
import 'package:dzevent/logic/cubits/auth/auth_cubit.dart';
import 'package:dzevent/logic/cubits/auth/auth_states.dart';
import 'package:dzevent/logic/cubits/events/events_cubit.dart';
import 'package:dzevent/logic/cubits/events/events_state.dart';
import 'package:dzevent/presentation/screens/add_event.dart';
import 'package:dzevent/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main(List<String> args) {
  runApp(const AssocProfTwo());
}

class AssocProfTwo extends StatefulWidget {
  const AssocProfTwo({super.key});

  @override
  State<AssocProfTwo> createState() => _AssocProfTwoState();
}

class _AssocProfTwoState extends State<AssocProfTwo> {
  UserModel? current_user;
  int id = 1;
  @override
  void initState() {
    super.initState();
    //store current user id
    //fetch events
    current_user = context.read<AccountCubit>().getCurrentUser();
    debugPrint(current_user?.id.toString() ?? "no id");
    if (current_user != null) {
      context.read<EventsCubit>().getAllEventsByUser(current_user!.id);
    } else {
      debugPrint("Fake id used");
      context.read<EventsCubit>().getAllEventsByUser(id);
    }
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

  Widget headerOfPage(String associationName, String desc) {
    final loc = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: CircleAvatar(backgroundImage: NetworkImage(logo), radius: 64),
        ),
        Text(
          associationName,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        Text(
          desc,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            getStatCard("1.2K", loc.subscribers),
            const SizedBox(width: 8),
            getStatCard("24", loc.eventsCount),
            const SizedBox(width: 8),
            getStatCard("5.8K", loc.interested),
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
                  ),
                  const SizedBox(width: 8),
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
                      const SizedBox(height: 8),
                      Text(
                        event.startDatetime.toString(),
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.blueAccent,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.people_outline, color: Colors.grey),
                          const SizedBox(width: 2),
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: Builder(
            builder: (context) {
              return IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Addevent()),
                  );
                },
              );
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              headerOfPage(
                "Tech Innovators Alliance", // dynamic data
                "Driving the future of technology through collaboration and innovation", // dynamic data
              ),
              const SizedBox(height: 32),
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
              current_user == null
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
                        }else{
                          debugPrint("no event fetched");
                        }
                        return Text("Unexpected state: ${state.runtimeType}");
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
