import 'package:dzevent/logic/cubits/auth/auth_cubit.dart';
import 'package:dzevent/logic/cubits/auth/auth_states.dart';
import 'package:dzevent/presentation/screens/add_event.dart';
import 'package:dzevent/presentation/screens/asosciationEventInterests.dart';
import 'package:dzevent/presentation/screens/associationProfileTwo.dart';
import 'package:dzevent/presentation/screens/event_feed.dart';
import 'package:dzevent/presentation/screens/followers.dart';
import 'package:dzevent/presentation/screens/interested_events.dart';
import 'package:dzevent/presentation/screens/login.dart';
import 'package:dzevent/presentation/screens/my_account_credentials.dart';
import 'package:dzevent/presentation/screens/notifications.dart';
import 'package:dzevent/presentation/screens/notifications.dart';
import 'package:dzevent/presentation/screens/user_profile.dart';
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
    bool isGuest,
  ) {
    return Drawer(
      child: Container(
        // The background color of the Drawer, using the theme's background
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Column(
          children: [
            // Enhanced Header
            // Container(
            //   decoration: BoxDecoration(
            //     // Using a gradient for visual appeal in the header
            //     gradient: LinearGradient(
            //       begin: Alignment.topLeft,
            //       end: Alignment.bottomRight,
            //       colors: [
            //         Theme.of(context).colorScheme.primary,
            //         Theme.of(context).colorScheme.primaryContainer,
            //       ],
            //     ),
            //   ),
            //   child: SafeArea(
            //     bottom: false,
            //     child: Container(
            //       padding: EdgeInsets.fromLTRB(20, 20, 20, 24),
            //       // Assuming ProfileHeader manages its own colors correctly
            //       child: isGuest ? _buildGuestHeader(context) : ProfileHeader(),
            //     ),
            //   ),
            // ),

            // Menu Items
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(vertical: 8),
                children: [
                  if (isGuest) ...[
                    _buildGuestWelcomeCard(context),
                    SizedBox(height: 16),
                  ],
                  if (drawerItemsUp.isNotEmpty) ...[
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 12, 20, 8),
                      child: Text(
                        "MENU",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          // Use a color that stands out, e.g., secondary or primary
                          color: Theme.of(context).colorScheme.secondary,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                    for (final item in drawerItemsUp)
                      _buildDrawerItem(
                        context: context,
                        label: item['label'] as String,
                        icon: item['icon'] as IconData,
                        onTap: item['route'] == null
                            ? null
                            : () {
                                Navigator.pop(context);
                                Navigator.of(context).push(
                                  (item['route']
                                      as MaterialPageRoute Function())(),
                                );
                              },
                      ),
                  ],
                ],
              ),
            ),

            // Bottom Items
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    // Use a subtle border color
                    color: Theme.of(context).colorScheme.outlineVariant,
                    width: 1,
                  ),
                ),
              ),
              child: Column(
                children: [
                  if (!isGuest)
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 12, 20, 8),
                      child: Text(
                        "PREFERENCES",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          // Use a color that stands out, e.g., secondary or primary
                          color: Theme.of(context).colorScheme.secondary,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                  for (final item in drawerItemsBottom)
                    _buildDrawerItem(
                      context: context,
                      label: item['label'] as String,
                      icon: item['icon'] as IconData,
                      isDestructive: item['label'] == "Log Out",
                      onTap: () async {
                        if (item['label'] == "Log Out") {
                          // The business logic is preserved here
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => ImageCarousel()),
                          );
                          // This line assumes 'AccountCubit' is the correct cubit for logout.
                          await context.read<AccountCubit>().logout();
                        }
                      },
                    ),
                  SizedBox(height: 8),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGuestHeader(BuildContext context) {
    // Colors should provide good contrast against the header gradient
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            // Use onPrimary to ensure visibility against the primary-based gradient
            color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.person_outline,
            size: 48,
            color: Theme.of(
              context,
            ).colorScheme.onPrimary, // e.g., white or a bright color
          ),
        ),
        SizedBox(height: 16),
        Text(
          "Welcome, Guest!",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Theme.of(
              context,
            ).colorScheme.onPrimary, // e.g., white or a bright color
          ),
        ),
        SizedBox(height: 4),
        Text(
          "Browse events and discover more",
          style: TextStyle(
            fontSize: 14,
            color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.9),
          ),
        ),
      ],
    );
  }

  Widget _buildGuestWelcomeCard(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            // Use primaryContainer for a light, inviting card background
            Theme.of(context).colorScheme.primaryContainer,
            Theme.of(context).colorScheme.secondaryContainer,
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.15),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Theme.of(
                    context,
                  ).colorScheme.primary, // Icon background
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.stars,
                  color: Theme.of(context).colorScheme.onPrimary, // Icon color
                  size: 24,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  "Get More Features",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    // Text color should contrast with primaryContainer
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Text(
            "Sign in to save favorites, RSVP to events, and get personalized recommendations!",
            style: TextStyle(
              fontSize: 13,
              color: Theme.of(
                context,
              ).colorScheme.onPrimaryContainer.withOpacity(0.8),
              height: 1.4,
            ),
          ),
          SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.primary.withOpacity(0.9),
                  ],
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(
                      context,
                    ).colorScheme.primary.withOpacity(0.3),
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: () {
                  // The business logic is preserved here
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => ImageCarousel()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  padding: EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  "Sign In / Sign Up",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(
                      context,
                    ).colorScheme.onPrimary, // Text color on primary
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required BuildContext context,
    required String label,
    required IconData icon,
    VoidCallback? onTap,
    bool isDestructive = false,
  }) {
    // Color fixes applied here for better theme adherence
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        // Use a slight primary color overlay on selection/hover
        color: onTap != null
            ? Theme.of(context).colorScheme.primary.withOpacity(0.05)
            : Colors.transparent,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    // Background for the icon
                    color: isDestructive
                        ? Theme.of(context).colorScheme.error.withOpacity(0.1)
                        : Theme.of(context).colorScheme.secondaryContainer
                              .withOpacity(0.6), // A softer tone
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    icon,
                    size: 22,
                    // Icon color
                    color: isDestructive
                        ? Theme.of(context).colorScheme.error
                        : Theme.of(context).colorScheme.primary,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Text(
                    label,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      // Text color
                      color: isDestructive
                          ? Theme.of(context).colorScheme.error
                          : Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 14,
                  // Use outline color for subtle indicator
                  color: Theme.of(context).colorScheme.outline,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // ... (drawerItemsUpAssociation, drawerItemsUpUser, drawerItemsBottom, drawerItemsBottomGuest are unchanged - Business Logic)

    final drawerItemsUpAssociation = [
      // {'label': "Feed", 'icon': Icons.home, 'route': () => EventFeed.route()},
      // {
      //   'label': "Profile",
      //   'icon': Icons.account_box,
      //   'route': () => AssocProfTwo.route(),
      // },
      {
        'label': "Notifications",
        'icon': Icons.notifications,
        'route': () => NotificationsPage.route(),
      },
      // {
      //   'label': "Add Event",
      //   'icon': Icons.add,
      //   'route': () => Addevent.route(),
      // },
      // {
      //   'label': "Interested Users",
      //   'icon': Icons.add_reaction,
      //   'route': () => AssociationInterestRequestsPage.route(),
      // },
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
        'route': () => NotificationsPage.route(),
      },
      {
        'label': "Followed Associations",
        'icon': Icons.group,
        'route': () => FollowedAssociationsScreen.route(),
      },
      {
        'label': "Profile",
        'icon': Icons.account_box,
        'route': () => Myaccountcredentials.route(),
      },
      //{'label': "Followed Associations", 'icon': Icons.group},
    ];
    final drawerItemsBottom = [
      {'label': "Settings", 'icon': Icons.settings},
      {'label': "Log Out", 'icon': Icons.logout},
    ];

    // final drawerItemsBottomGuest = [
    //   {'label': "Log Out", 'icon': Icons.logout},
    // ];

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: title,
        actions: actions,
        // Ensure AppBar colors match the surface
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        surfaceTintColor: Theme.of(context).colorScheme.surface,
        leading: Builder(
          builder: (context) => Container(
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
              // Use primaryContainer for a soft, themed background
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              icon: Icon(
                Icons.menu,
                // Use primary for the icon color
                color: Theme.of(context).colorScheme.primary,
              ),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
        ),
      ),
      // ... (BlocBuilder and body are unchanged - Business Logic)
      drawer: BlocBuilder<AccountCubit, AccountState>(
        builder: (context, state) {
          if (state is AssociationFetched ||
              state is AssoicationDetailFetched) {
            return drawer(
              drawerItemsUpAssociation,
              drawerItemsBottom,
              context,
              false,
            );
          } else if (state is UserFetched) {
            return drawer(drawerItemsUpUser, drawerItemsBottom, context, false);
          }
          return drawer([], [], context, true);
        },
      ),
      body: body,
    );
  }
}
