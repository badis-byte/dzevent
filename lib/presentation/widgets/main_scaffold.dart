import 'package:dzevent/presentation/screens/event_feed.dart';
import 'package:dzevent/presentation/screens/interested_events.dart';
import 'package:dzevent/presentation/widgets/profile_header.dart';
import 'package:flutter/material.dart';

class MainScaffold extends StatelessWidget {
  final Widget body;
  final Widget title;
  final List<Widget> actions;

  const MainScaffold({
    super.key,
    required this.title,
    required this.body,
    this.actions = const [],
  });

  @override
  Widget build(BuildContext context) {
    final drawerItemsUp = [
      {'label': "Feed", 'icon': Icons.home, 'route': () => EventFeed.route()},
      {
        'label': "Interested",
        'icon': Icons.calendar_month,
        'route': () => InterestedEventsScreen.route(),
      },
      {'label': "Notifications", 'icon': Icons.notifications},
      {'label': "Followed Associations", 'icon': Icons.group},
    ];
    final drawerItemsBottom = [
      {'label': "Settings", 'icon': Icons.settings},
      {'label': "Log Out", 'icon': Icons.logout},
    ];

    return Scaffold(
      appBar: AppBar(title: title, actions: actions, backgroundColor: const Color.fromARGB(255, 161, 213, 255),),
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(child: ProfileHeader()),
            for (final item in drawerItemsUp)
              InkWell(
                onTap: item['route'] == null
                    ? null
                    : () {
                        Navigator.of(context).pushReplacement(
                          (item['route'] as MaterialPageRoute Function())(),
                        );
                      },
                hoverColor: Colors.grey.shade200,
                child: ListTile(
                  title: Text(item['label'] as String),
                  leading: Icon(item['icon'] as IconData),
                ),
              ),
            Spacer(),
            Divider(),
            for (final item in drawerItemsBottom)
              InkWell(
                onTap: () {},
                hoverColor: Colors.grey.shade200,
                child: ListTile(
                  title: Text(item['label'] as String),
                  leading: Icon(item['icon'] as IconData),
                ),
              ),
          ],
        ),
      ),
      body: body,
    );
  }
}
