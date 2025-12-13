import 'package:dzevent/data/models/event_model.dart';
import 'package:dzevent/data/models/user_model.dart';
import 'package:flutter/material.dart';

class AssociationInterestRequestsPage extends StatefulWidget {
  const AssociationInterestRequestsPage({super.key});

  static MaterialPageRoute route() => MaterialPageRoute(
        builder: (context) => const AssociationInterestRequestsPage(),
      );

  @override
  State<AssociationInterestRequestsPage> createState() =>
      _AssociationInterestRequestsPageState();
}

class _AssociationInterestRequestsPageState
    extends State<AssociationInterestRequestsPage> {
  final List<Map<String, dynamic>> requests = [
    {
      "user": UserModel(
        id: 1,
        name: "John Doe",
        email: "john.doe@example.com",
        password: "password",
        profilePicture: "assets/profile1.png",
        createdAt: DateTime.now(),
      ),
      "event": EventModel(
        id: "e1",
        title: "Mountain Adventure Hike",
        description: "A challenging hike through the mountains.",
        startDatetime: DateTime.now(),
        endDatetime: DateTime.now().add(const Duration(hours: 4)),
        imageUrl: "assets/event1.png",
        location: "Atlas Mountains",
        createdAt: DateTime.now(),
        associationId: 101,
        category: "Hiking",
      ),
    },
    {
      "user": UserModel(
        id: 2,
        name: "Sara Ben",
        email: "sara.ben@example.com",
        password: "password",
        profilePicture: "assets/profile2.png",
        createdAt: DateTime.now(),
      ),
      "event": EventModel(
        id: "e2",
        title: "Sunset Trail Walk",
        description: "A relaxing walk during sunset.",
        startDatetime: DateTime.now(),
        endDatetime: DateTime.now().add(const Duration(hours: 2)),
        imageUrl: "assets/event2.png",
        location: "City Park",
        createdAt: DateTime.now(),
        associationId: 102,
        category: "Walking",
      ),
    },
  ];

  // Function to create a single request card
  Widget requestCard(EventModel event, UserModel user) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        margin: const EdgeInsets.only(bottom: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.name,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              Text(
                event.title,
                style: const TextStyle(fontSize: 16, color: Colors.blueAccent),
              ),
              const SizedBox(height: 10),
              const Text(
                "User Email:",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              Text(user.email, style: const TextStyle(fontSize: 15)),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Interest Requests"), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            for (var item in requests)
              requestCard(item["event"]!, item["user"]!),
          ],
        ),
      ),
    );
  }
}
