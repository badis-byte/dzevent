import 'package:dzevent/data/models/assoc_model.dart';
import 'package:dzevent/l10n/app_localizations.dart';
import 'package:dzevent/data/models/event_model.dart';
import 'package:dzevent/lib/defs.dart';
import 'package:dzevent/lib/styles.dart';
import 'package:dzevent/logic/cubits/auth/auth_cubit.dart';
import 'package:dzevent/logic/cubits/events/events_cubit.dart';
import 'package:dzevent/logic/cubits/events/events_state.dart';
import 'package:dzevent/logic/cubits/followers/followers_cubits.dart';
import 'package:dzevent/logic/cubits/followers/followers_state.dart';
import 'package:dzevent/presentation/screens/event_details.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:dzevent/data/fake_data.dart' as DATA;
import 'package:flutter_bloc/flutter_bloc.dart';

class PublicAssocProfile extends StatefulWidget {
  final AssociationModel asso;
  const PublicAssocProfile({super.key, required this.asso});

  static const contactIcon = {
    ContactInfoType.email: Icons.email_outlined,
    ContactInfoType.phone: Icons.phone,
    ContactInfoType.web: Icons.web,
  };

  @override
  State<PublicAssocProfile> createState() => _PublicAssocProfileState();
}

class _PublicAssocProfileState extends State<PublicAssocProfile>
    with TickerProviderStateMixin {
  late final Association association;
  bool isFollowing = false;
  final imageSize = Size(150, 150);

  int? loggedInId; // user OR association ID

  @override
  void initState(){
    super.initState();

    /// Prepare the Association object
    association = Association(
      id: widget.asso.id!,
      name: widget.asso.name,
      imageUrl: widget.asso.profilePicture,
      brief: widget.asso.bio,
      aboutUs: widget.asso.bio,
      contactInfo: [
        ContactInfo(type: ContactInfoType.email, address: widget.asso.email),
        ContactInfo(type: ContactInfoType.phone, address: "0695837395"),
        ContactInfo(type: ContactInfoType.web, address: "www.lorem.com"),
      ],
    );

    // Future<void> getF(assocId)async{
    //   var state= context.read<FollowCubit>().state;
    //   // Determine if currently following
    //   if (state is FollowListFetched) {
    //     isFollowing = state.followedAssociationIds.contains(assocId);
    //   }else{
    //     await context.read<FollowCubit>().getFollowedAssociations(loggedInId!);
    //     if (state is FollowListFetched) {
    //     isFollowing = state.followedAssociationIds.contains(assocId);
    //   }
    //   }
    // }
    // getF(association.id);

    /// Determine logged-in identity (user or association)
    final acc = context.read<AccountCubit>();
    if (acc.association == true) {
      loggedInId = acc.currentAssociation!.id;
    } else{
      loggedInId = acc.currentUser!.id;
    }
    //load followed associations
    context.read<FollowCubit>().getFollowedAssociations(loggedInId!);

    /// Load association's events ONCE
    if (widget.asso.id != null) {
      context.read<EventsCubit>().getAllEventsByUser(widget.asso.id!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.share))],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: SingleChildScrollView(
          child: Column(
            children: [
              buildInfo(context, loc),
              SizedBox(height: 16),
              buildEventTabBar(context, loc),
            ],
          ),
        ),
      ),
    );
  }

  Column buildInfo(BuildContext context, AppLocalizations loc){
    return Column(
      children: [
        /// Profile Image
        Container(
          width: imageSize.width,
          height: imageSize.height,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(shape: BoxShape.circle),
          child: Image.network(
            association.imageUrl,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) =>
                Icon(Icons.account_balance, size: 64),
          ),
        ),

        SizedBox(height: 12),
        Text(association.name, style: headingStyle),
        Text(
          association.brief,
          style: subtitleStyle,
          textAlign: TextAlign.center,
        ),

        SizedBox(height: 16),

        /// FOLLOW BUTTON
        // FOLLOW BUTTON
        // FOLLOW BUTTON
BlocBuilder<FollowCubit, FollowState>(
  builder: (context, state) {
    bool isFollowing = false;

    if (state is FollowListFetched) {
      isFollowing = state.followedAssociationIds.contains(widget.asso.id);
    }

    return ElevatedButton(

      style: getPrimaryBtnStyle(context: context),
      onPressed: () {
        final followCubit = context.read<FollowCubit>();
        if (isFollowing) {
          followCubit.unfollow(loggedInId!, widget.asso.id!);
        } else {
          followCubit.follow(loggedInId!, widget.asso.id!);
        }
      },
      child: Text(isFollowing ? "Unfollow" : "Follow"),
    );
  },
),

        SizedBox(height: 16),

        /// ABOUT
        SizedBox(
          width: double.infinity,
          child: Text(loc.aboutUs, style: headingStyle),
        ),
        Text(association.aboutUs, style: bodyTextStyle),

        SizedBox(height: 16),

        /// CONTACT INFO
        SizedBox(
          width: double.infinity,
          child:
              Text(loc.contactInformation, style: headingStyle, textAlign: TextAlign.left),
        ),

        for (final contact in association.contactInfo)
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Container(
              padding: EdgeInsets.all(8),
              color: Theme.of(context).colorScheme.primaryContainer,
              child: Icon(PublicAssocProfile.contactIcon[contact.type]),
            ),
            title: Text(contact.address),
          ),
      ],
    );
  }

  Widget buildEventTabBar(BuildContext context, AppLocalizations loc) {
    return DefaultTabController(
      length: 2,
      child: Container(
        color: Theme.of(context).colorScheme.surfaceContainer,
        child: Column(
          children: [
            TabBar(
              tabs: [
                Tab(text: loc.upcomingEvents),
                Tab(text: loc.pastEvents),
              ],
            ),
            SizedBox(
              height: 300,
              child: TabBarView(
                children: [
                  /// TAB 1 — Events from API
                  BlocBuilder<EventsCubit, EventsState>(
                    builder: (context, state) {
                      if (state is EventsLoading) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (state is EventsError) {
                        return Center(child: Text("Error loading events"));
                      }
                      if (state is EventsFetched) {
                        if (state.events.isEmpty) {
                          return Center(child: Text("No events"));
                        }

                        return ListView.builder(
                          itemCount: state.events.length,
                          itemBuilder: (context, index) {
                            final event = state.events[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        EventDetails(event: event),
                                  ),
                                );
                              },
                              child: buildEventItem(context, event: event),
                            );
                          },
                        );
                      }
                      return SizedBox();
                    },
                  ),

                  /// TAB 2 — Fake events
                  ListView.builder(
                    itemCount: DATA.events.length,
                    itemBuilder: (context, index) =>
                        buildEventItem(context, event: DATA.events[index]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildEventItem(BuildContext context,
      {required EventModel event}) {
    return Container(
      padding: EdgeInsets.all(8),
      color: Theme.of(context).colorScheme.surface,
      child: Row(
        children: [
          SizedBox(
            width: 150,
            height: 150,
            child: Image.network(
              association.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  Icon(Icons.account_balance),
            ),
          ),
          SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat("E, MMM d · h:mm a").format(event.startDatetime),
              ),
              Text(event.title, style: subtitleStyle),
              Text(event.location, style: bodyTextStyle),
            ],
          ),
        ],
      ),
    );
  }
}
