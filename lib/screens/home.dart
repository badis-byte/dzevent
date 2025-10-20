import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        NavigationRail(
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          destinations: [
            NavigationRailDestination(
              icon: Icon(Icons.abc),
              label: Text("abc"),
            ),
          ],
          selectedIndex: 0,
        ),
        Expanded(child: Center(child: Text("This is a temporary page"))),
      ],
    );
  }
}
