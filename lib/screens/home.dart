import 'package:dzevent/screens/addEvent.dart';
import 'package:dzevent/screens/assocAdmin.dart';
import 'package:dzevent/screens/associationProfileTwo.dart';
import 'package:dzevent/screens/event_details.dart';
import 'package:dzevent/screens/event_feed.dart';
import 'package:dzevent/screens/public_assoc_profile.dart';
import 'package:dzevent/screens/signup.dart';
import 'package:dzevent/screens/welcome.dart';
import 'package:flutter/material.dart';
import 'package:dzevent/screens/login.dart';
import 'package:dzevent/screens/my_account_credentials.dart';
import 'package:dzevent/screens/reg_user_profile.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// # New Screen Setup
/// - Add screen entry to _links
///
/// - ensure [page] is the screen compoenent
///
/// **NOTE**
///
/// NavScreenLink is provided for you. You can use it to return back
/// to NavScreen
class Link {
  final IconData icon;
  final String label;
  final Widget page;
  const Link({required this.icon, required this.label, required this.page});
}

final _links = [
  Link(icon: Icons.add, label: "add event", page: Addevent()),
  Link(icon: Icons.person, label: "assocAdmin", page: Assocadmin()),
  Link(icon: Icons.person, label: "assocProfileTwo", page: AssocProfTwo()),

  Link(
    icon: Icons.details_outlined,
    label: "event_details",
    page: EventDetails(),
  ),
  Link(icon: Icons.event, label: "event_feed", page: EventFeed()),
  Link(icon: Icons.login, label: "Login", page: Login()),
  Link(
    icon: Icons.person,
    label: "public_assoc_profile",
    page: PublicAssocProfile(),
  ),
  Link(icon: Icons.add, label: "signup", page: Signup()),
  Link(icon: Icons.handshake, label: "welcome", page: ImageCarousel()),

  Link(
    icon: Icons.person,
    label: "public association profile",
    page: PublicAssocProfile(),
  ),
  Link(icon: Icons.add, label: "creds", page: Myaccountcredentials()),
  Link(icon: Icons.add, label: "user regs", page: ProfileScreen()),
];

class NavScreen extends StatelessWidget {
  const NavScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final postFuture = Supabase.instance.client.from('Post').select();

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
          Expanded(
            child: FutureBuilder(
              future: postFuture,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                final posts = snapshot.data!;
                return ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, index) => Text(posts[index]['name']),
                );
              },
            ),
          ),
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
