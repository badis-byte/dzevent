import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        NavigationRail(
          destinations: [
            NavigationRailDestination(
              icon: Icon(Icons.abc),
              label: Text("abc"),
            ),
          ],
          selectedIndex: 0,
        ),
        Center(child: Text("This is a temporary page")),
      ],
    );
  }
}
