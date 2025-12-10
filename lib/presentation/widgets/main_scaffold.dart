import 'package:dzevent/logic/cubits/auth/auth_cubit.dart';
import 'package:dzevent/logic/cubits/auth/auth_states.dart';
import 'package:dzevent/presentation/screens/add_event.dart';
import 'package:dzevent/presentation/screens/asosciationEventInterests.dart';
import 'package:dzevent/presentation/screens/associationProfileTwo.dart';
import 'package:dzevent/presentation/screens/event_feed.dart';
import 'package:dzevent/presentation/screens/interested_events.dart';
import 'package:dzevent/presentation/screens/login.dart';
import 'package:dzevent/presentation/screens/welcome.dart';
import 'package:dzevent/presentation/widgets/profile_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  Widget drawer(
    List drawerItemsUp,
    List drawerItemsBottom,
    BuildContext context,
  ) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(child: ProfileHeader()),
          for (final item in drawerItemsUp)
            InkWell(
              onTap: item['route'] == null
                  ? null
                  : () {
                      Navigator.of(
                        context,
                      ).push((item['route'] as MaterialPageRoute Function())());
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
              onTap: () {
                if (item['label'] == "Log Out") {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => ImageCarousel()),
                  );
                  context.read<AccountCubit>().logout();
                }
              },
              hoverColor: Colors.grey.shade200,
              child: ListTile(
                title: Text(item['label'] as String),
                leading: Icon(item['icon'] as IconData),
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final drawerItemsUpAssociation = [
      {'label': "Feed", 'icon': Icons.home, 'route': () => EventFeed.route()},
      {
        'label': "Profile",
        'icon': Icons.account_box,
        'route': () => AssocProfTwo.route(),
      },
      {
        'label': "Notifications",
        'icon': Icons.notifications,
        // 'route': () => Notification.route(),
      },
      {
        'label': "Add Event",
        'icon': Icons.add,
        'route': () => Addevent.route(),
      },
      {
        'label': "Interested Users",
        'icon': Icons.add_reaction,
        'route': () => AssociationInterestRequestsPage.route(),
      },
    ];
    final drawerItemsUpUser = [
      {'label': "Feed", 'icon': Icons.home, 'route': () => EventFeed.route()},
      {
        'label': "Interested",
        'icon': Icons.calendar_month,
        'route': () => InterestedEventsScreen.route(),
      },
      {
        'label': "Notifications",
        'icon': Icons.notifications,
        // 'route': () => NotificationScreen.route(),
      },
      {'label': "Followed Associations", 'icon': Icons.group},
    ];
    final drawerItemsBottom = [
      {'label': "Settings", 'icon': Icons.settings},
      {'label': "Log Out", 'icon': Icons.logout},
    ];

    final drawerItemsBottomGuest = [
      {'label': "Log Out", 'icon': Icons.logout},
    ];

    return Scaffold(
      appBar: AppBar(
        title: title,
        actions: actions,
        backgroundColor: const Color.fromARGB(255, 161, 213, 255),
      ),
      drawer: BlocBuilder<AccountCubit, AccountState>(
        builder: (context, state) {
          if (state is AssociationFetched) {
            return drawer(drawerItemsUpAssociation, drawerItemsBottom, context);
          } else if (state is UserFetched) {
            return drawer(drawerItemsUpUser, drawerItemsBottom, context);
          }
          return drawer([], drawerItemsBottomGuest, context);
        },
      ),
      body: body,
    );
  }
}
