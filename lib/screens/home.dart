import 'package:dzevent/screens/event_feed.dart';
import 'package:flutter/material.dart';

class Link {
  final IconData icon;
  final String label;
  final Widget page;
  const Link({required this.icon, required this.label, required this.page});
}

final _links = [
  Link(icon: Icons.event, label: "event_feed", page: EventFeed()),
];

class NavScreen extends StatelessWidget {
  const NavScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            extended: true,
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            destinations: [
              for (final link in _links)
                NavigationRailDestination(
                  icon: Icon(link.icon),
                  label: Text(link.label),
                ),
            ],
            selectedIndex: 0,
            onDestinationSelected: (value) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => _links[value].page),
              );
            },
          ),
          Expanded(child: Center(child: Text("This is a temporary page"))),
        ],
      ),
    );
  }
}

class NavScreenLink extends StatelessWidget {
  const NavScreenLink({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Theme.of(context).colorScheme.onPrimary,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NavScreen()),
            );
          },
          child: const Text("Home"),
        ),
      ),
    );
  }
}
