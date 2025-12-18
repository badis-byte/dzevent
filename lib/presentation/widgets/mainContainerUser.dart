import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:dzevent/presentation/screens/add_event.dart';
import 'package:dzevent/presentation/screens/asosciationEventInterests.dart';
import 'package:dzevent/presentation/screens/associationProfileTwo.dart';
import 'package:dzevent/presentation/screens/event_feed.dart';
import 'package:dzevent/presentation/screens/followers.dart';
import 'package:dzevent/presentation/screens/interested_events.dart';
import 'package:dzevent/presentation/screens/my_account_credentials.dart';
import 'package:dzevent/presentation/screens/notifications.dart';
import 'package:flutter/material.dart';

// SIMPLE 3-STEP SETUP:

// STEP 1: Create one main widget with the nav bar
class MainContainerUser extends StatefulWidget {
  const MainContainerUser({super.key});
  static MaterialPageRoute route() =>
      MaterialPageRoute(builder: (context) => MainContainerUser());
  @override
  State<MainContainerUser> createState() => _MainContainerUserState();
}

class _MainContainerUserState extends State<MainContainerUser> {
  int _currentPage = 0;

  // STEP 2: List all your pages
  final List<Widget> _pages = [
    EventFeed(),   // Page 0 - Home
    InterestedEventsScreen(), // Page 1 - Add
    FollowedAssociationsScreen(),
    Myaccountcredentials(),     // Page 2 - Profile
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentPage], // Show current page
      
      // STEP 3: Add nav bar that switches pages
      bottomNavigationBar: CurvedNavigationBar(
        index: _currentPage,
        height: 48,
        backgroundColor: Colors.transparent,
        color: Colors.white,
        buttonBackgroundColor: Theme.of(context).colorScheme.primary,
        animationDuration: const Duration(milliseconds: 300),
        animationCurve: Curves.easeInOutCubic,
        items: [
          Icon(
            Icons.home_rounded,
            size: 28,
            color: _currentPage == 0 ? Colors.white : Theme.of(context).colorScheme.primary,
          ),
          Icon(
            Icons.calendar_month,
            size: 32,
            color: _currentPage == 1 ? Colors.white : Theme.of(context).colorScheme.primary,
          ),
          Icon(
            Icons.group,
            size: 32,
            color: _currentPage == 2 ? Colors.white : Theme.of(context).colorScheme.primary,
          ),
          Icon(
            Icons.account_box,
            size: 28,
            color: _currentPage == 3 ? Colors.white : Theme.of(context).colorScheme.primary,
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
