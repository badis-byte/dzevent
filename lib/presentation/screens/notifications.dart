import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});
  static MaterialPageRoute route() =>
      MaterialPageRoute(builder: (context) => NotificationScreen());
  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final List<Map<String, String>> notifications = const [
    {
      "title": "New Event Added",
      "body": "A new hiking event is now available.",
      "time": "2h ago",
    },
    {
      "title": "Reminder",
      "body": "Don’t forget your event tomorrow!",
      "time": "5h ago",
    },
    {
      "title": "Update",
      "body": "Your reservation has been approved.",
      "time": "Yesterday",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Notifications"), centerTitle: true),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final item = notifications[index];

          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: const Icon(Icons.notifications, size: 30),
              title: Text(item["title"]!),
              subtitle: Text(item["body"]!),
              trailing: Text(
                item["time"]!,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
          );
        },
      ),
    );
  }
}
