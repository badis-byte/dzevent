import 'package:dzevent/presentation/screens/add_event.dart';
import 'package:dzevent/presentation/screens/assocAdmin.dart';
import 'package:dzevent/presentation/screens/associationProfileTwo.dart';
import 'package:dzevent/presentation/screens/event_feed.dart';
import 'package:dzevent/presentation/screens/signup.dart';
import 'package:dzevent/presentation/screens/welcome.dart';
import 'package:flutter/material.dart';
import 'package:dzevent/presentation/screens/login.dart';
import 'package:dzevent/presentation/screens/my_account_credentials.dart';
import 'package:dzevent/presentation/screens/user_profile.dart';
import 'package:dzevent/l10n/app_localizations.dart';

/// # New Screen Setup
/// - Add screen entry to _links
///
/// - ensure [page] is the screen component
///
/// **NOTE**
///
/// NavScreenLink is provided for you. You can use it to return back
class Link {
  final IconData icon;
  final String label;
  final Widget page;
  const Link({required this.icon, required this.label, required this.page});
}

class NavScreen extends StatelessWidget {
  const NavScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    final links = [
      Link(icon: Icons.add, label: loc.addEvent, page: Addevent()),
      Link(icon: Icons.person, label: loc.assocAdmin, page: Assocadmin()),
      Link(
        icon: Icons.person,
        label: loc.assocProfileTwo,
        page: AssocProfTwo(),
      ),
      Link(icon: Icons.event, label: loc.eventFeed, page: EventFeed()),
      Link(icon: Icons.login, label: loc.login, page: Login()),
      // Link(
      //   icon: Icons.person,
      //   label: loc.publicAssocProfile,
      //   page: PublicAssocProfile(),
      // ),
      Link(icon: Icons.add, label: loc.signup, page: Signup()),
      Link(icon: Icons.handshake, label: loc.welcome, page: ImageCarousel()),
      // Link(
      //   icon: Icons.person,
      //   label: loc.publicAssocProfile,
      //   // page: PublicAssocProfile(),
      // ),
      Link(icon: Icons.add, label: loc.creds, page: Myaccountcredentials()),
      Link(icon: Icons.add, label: loc.userRegs, page: UserMenu()),
    ];

    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            extended: true,
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            destinations: [
              for (final link in links)
                NavigationRailDestination(
                  icon: Icon(link.icon),
                  label: Text(link.label),
                ),
            ],
            selectedIndex: 0,
            onDestinationSelected: (value) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => links[value].page),
              );
            },
          ),
          Center(child: Text("EMPTY")),
        ],
      ),
    );
  }
}

class NavScreenLink extends StatelessWidget {
  const NavScreenLink({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

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
              MaterialPageRoute(builder: (context) => const NavScreen()),
            );
          },
          child: Text(loc.home),
        ),
      ),
    );
  }
}
