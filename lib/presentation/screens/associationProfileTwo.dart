import 'package:dzevent/presentation/screens/addEvent.dart';
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
    String eventImage,
    String eventTitle,
    String eventDate,
    String eventTime,
    int numOfMembers,
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
                    image: NetworkImage(eventImage),
                    width: 120,
                    height: 120,
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        eventTitle,
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "$eventDate - $eventTime",
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
                            loc.interestedCount(numOfMembers),
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
                      eventCard(
                        logo,
                        "Tech Innovators Meetup", // dynamic
                        "2025-11-15",
                        "10:00 AM",
                        120,
                      ),
                      eventCard(
                        logo,
                        "Jazz Night", // dynamic
                        "2025-12-02",
                        "7:30 PM",
                        85,
                      ),
                      eventCard(
                        logo,
                        "Modern Art Expo", // dynamic
                        "2026-01-10",
                        "3:00 PM",
                        45,
                      ),
                      eventCard(
                        logo,
                        "City Marathon", // dynamic
                        "2025-11-25",
                        "6:00 AM",
                        300,
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
