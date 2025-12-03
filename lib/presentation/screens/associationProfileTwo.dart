import 'package:dzevent/data/models/event_model.dart';
import 'package:dzevent/presentation/screens/add_event.dart';
import 'package:dzevent/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(const AssocProfTwo());
}

class AssocProfTwo extends StatefulWidget {
  const AssocProfTwo({super.key});

  @override
  State<AssocProfTwo> createState() => _AssocProfTwoState();
}

class _AssocProfTwoState extends State<AssocProfTwo> {
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

  Widget eventCard(
    EventModel event
  ) {
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
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Addevent(event: event,)),
                          );
                        },
                      ),
                      const PopupMenuItem(
                        value: 'delete',
                        child: Text('Delete'),
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
    EventModel event1 = EventModel(id: "1", title: "Tech Innovators Meetup", description: "Join us for a day of tech talks and networking.", startDatetime: DateTime(2025, 11, 15, 10, 0), endDatetime: DateTime(2025, 11, 15, 17, 0), imageUrl: logo, location: "Tech Hub", createdAt: DateTime.now(), associationId: 1, category: "Meetup");
    EventModel event2 = EventModel(id: "2", title: "AI Conference", description: "Explore the latest advancements in AI.", startDatetime: DateTime(2025, 12, 10, 9, 0), endDatetime: DateTime(2025, 12, 10, 18, 0), imageUrl: logo, location: "Innovation Center", createdAt: DateTime.now(), associationId: 1, category: "Conference");
    EventModel event3 = EventModel(id: "3", title: "Blockchain Workshop", description: "Learn about the future of blockchain technology.", startDatetime: DateTime(2025, 12, 15, 10, 0), endDatetime: DateTime(2025, 12, 15, 17, 0), imageUrl: logo, location: "Tech Hub", createdAt: DateTime.now(), associationId: 1, category: "Workshop");
    EventModel event4 = EventModel(id: "4", title: "Cybersecurity Summit", description: "Discuss the latest trends in cybersecurity.", startDatetime: DateTime(2025, 12, 20, 9, 0), endDatetime: DateTime(2025, 12, 20, 18, 0), imageUrl: logo, location: "Innovation Center", createdAt: DateTime.now(), associationId: 1, category: "Conference");
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
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      eventCard(event1
                      ),
                      eventCard(
                        event2
                      ),
                      eventCard(
                        event3
                      ),
                      eventCard(
                        event4
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
