import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:dzevent/presentation/screens/add_event.dart';
import 'package:dzevent/presentation/screens/asosciationEventInterests.dart';
import 'package:dzevent/presentation/screens/associationProfileTwo.dart';
import 'package:dzevent/presentation/screens/event_feed.dart';
import 'package:flutter/material.dart';

// SIMPLE 3-STEP SETUP:

// STEP 1: Create one main widget with the nav bar
class MainContainerAsso extends StatefulWidget {
  const MainContainerAsso({super.key});
  static MaterialPageRoute route() =>
      MaterialPageRoute(builder: (context) => MainContainerAsso());
  @override
  State<MainContainerAsso> createState() => _MainContainerAssoState();
}

class _MainContainerAssoState extends State<MainContainerAsso> {
  int _currentPage = 0;

  // STEP 2: List all your pages
  final List<Widget> _pages = [
    EventFeed(),
    Addevent(),
    AssociationInterestRequestsPage(),
    AssocProfTwo(), // Page 2 - Profile
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: _pages[_currentPage], // Show current page
      // STEP 3: Add nav bar that switches pages
      bottomNavigationBar: CurvedNavigationBar(
        index: _currentPage,
        height: 48,
        backgroundColor: Colors.transparent,
        color: Theme.of(context).colorScheme.surface,
        buttonBackgroundColor: Theme.of(context).colorScheme.primary,
        animationDuration: const Duration(milliseconds: 300),
        animationCurve: Curves.easeInOutCubic,
        items: [
          Icon(
            Icons.home_rounded,
            size: 28,
            color: _currentPage == 0
                ? Colors.white
                : Theme.of(context).colorScheme.primary,
          ),
          Icon(
            Icons.add_circle_rounded,
            size: 32,
            color: _currentPage == 1
                ? Colors.white
                : Theme.of(context).colorScheme.primary,
          ),
          Icon(
            Icons.add_reaction,
            size: 32,
            color: _currentPage == 2
                ? Colors.white
                : Theme.of(context).colorScheme.primary,
          ),
          Icon(
            Icons.person_rounded,
            size: 28,
            color: _currentPage == 3
                ? Colors.white
                : Theme.of(context).colorScheme.primary,
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentPage = index;
          });
        },
      ),
    );
  }
}
