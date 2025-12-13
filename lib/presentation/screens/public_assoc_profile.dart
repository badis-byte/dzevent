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
  int? loggedInId;
  late AnimationController _headerController;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  final ScrollController _scrollController = ScrollController();
  double _scrollOffset = 0;

  @override
  void initState() {
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
    _headerController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    )..forward();

    _fadeController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    )..forward();

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeIn),
    );

    _scrollController.addListener(() {
      setState(() {
        _scrollOffset = _scrollController.offset;
      });
    });
  }

  @override
  void dispose() {
    _headerController.dispose();
    _fadeController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Container(
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.3),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back, color: Colors.white),
          ),
        ),
        actions: [
          Container(
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.share, color: Colors.white),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            _buildHeroHeader(context, loc),
            Transform.translate(
              offset: Offset(0, -30),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      _buildActionButtons(context, loc),
                      SizedBox(height: 32),
                      buildInfo(context, loc),
                      SizedBox(height: 24),
                      buildEventTabBar(context, loc),
                      SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroHeader(BuildContext context, AppLocalizations loc) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Stack(
      children: [
        // Background gradient with parallax effect
        Container(
          height: 350,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.primary.withOpacity(0.8),
                Theme.of(context).colorScheme.primaryContainer,
              ],
            ),
          ),
        ),
        // Animated overlay pattern
        Container(
          height: 350,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.black.withOpacity(isDark ? 0.6 : 0.3),
              ],
            ),
          ),
        ),
        // Content
        Positioned.fill(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 80),
              ScaleTransition(
                scale: Tween<double>(begin: 0.5, end: 1.0).animate(
                  CurvedAnimation(
                    parent: _headerController,
                    curve: Curves.elasticOut,
                  ),
                ),
                child: Hero(
                  tag: 'assoc_${widget.asso.id}',
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 20,
                          spreadRadius: 5,
                        ),
                      ],
                      border: Border.all(color: Colors.white, width: 4),
                    ),
                    child: Container(
                      width: 140,
                      height: 140,
                      decoration: BoxDecoration(shape: BoxShape.circle),
                      clipBehavior: Clip.antiAlias,
                      child: Image.network(
                        association.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Theme.of(context).colorScheme.primaryContainer,
                            child: Icon(Icons.account_balance, size: 60, color: Colors.white),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              FadeTransition(
                opacity: _fadeAnimation,
                child: Column(
                  children: [
                    Text(
                      association.name,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              ),
            ],
          ),
        ),
      ],
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
    bool isLoading = state is FollowLoading;

    if (state is FollowListFetched) {
      isFollowing = state.followedAssociationIds.contains(widget.asso.id);
    }

    return ElevatedButton(
      onPressed: isLoading ? null : () {
        final cubit = context.read<FollowCubit>();
        final currentState = cubit.state;

        bool followingNow = false;
        if (currentState is FollowListFetched) {
          followingNow = currentState.followedAssociationIds.contains(widget.asso.id);
        }

        if (followingNow) {
          cubit.unfollow(loggedInId!, widget.asso.id!);
        } else {
          cubit.follow(loggedInId!, widget.asso.id!);
        }
      },
      child: isLoading
          ? SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2))
          : Text(isFollowing ? "Unfollow" : "Follow"),
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
  Widget _buildActionButtons(BuildContext context, AppLocalizations loc) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.primary.withOpacity(0.7),
                ],
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                  blurRadius: 12,
                  offset: Offset(0, 6),
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.white,
                shadowColor: Colors.transparent,
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add_circle_outline, size: 22, color: Colors.white),
                  SizedBox(width: 8),
                  Text(
                    loc.followAssociation,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(width: 12),
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainer,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Theme.of(context).colorScheme.outline.withOpacity(0.3),
            ),
          ),
          child: IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications_outlined),
            iconSize: 24,
          ),
        ),
      ],
    );
  }

  Column buildInfo(BuildContext context, AppLocalizations loc) {
    return Column(
      children: [
        _buildSectionHeader(context, loc.aboutUs, Icons.info_outline),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainer,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Theme.of(context).colorScheme.outline.withOpacity(0.1),
            ),
          ),
          child: Text(
            association.aboutUs,
            style: bodyTextStyle.copyWith(height: 1.6),
          ),
        ),
        SizedBox(height: 32),
        _buildSectionHeader(context, loc.contactInformation, Icons.contact_page_outlined),
        SizedBox(height: 12),
        ...association.contactInfo.map((contact) => _buildContactCard(context, contact)).toList(),
      ],
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title, IconData icon) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, size: 20, color: Theme.of(context).colorScheme.primary),
        ),
        SizedBox(width: 12),
        Text(
          title,
          style: headingStyle.copyWith(fontSize: 20),
        ),
      ],
    );
  }

  Widget _buildContactCard(BuildContext context, ContactInfo contact) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.1),
        ),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            PublicAssocProfile.contactIcon[contact.type],
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        title: Text(
          contact.address,
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Theme.of(context).colorScheme.outline,
        ),
      ),
    );
  }

  Widget buildEventTabBar(BuildContext context, AppLocalizations loc) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainer,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Theme.of(context).colorScheme.outline.withOpacity(0.1),
              ),
            ),
            child: TabBar(
              indicator: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(16),
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              dividerColor: Colors.transparent,
              labelColor: Colors.white,
              unselectedLabelColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
              labelStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
              unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
              padding: EdgeInsets.all(6),
              tabs: [
                Tab(text: loc.upcomingEvents),
                Tab(text: loc.pastEvents),
              ],
            ),
          ),
          SizedBox(height: 16),
          SizedBox(
            height: 400,
            child: TabBarView(
              children: [
                BlocBuilder<EventsCubit, EventsState>(
                  builder: (context, state) {
                    if (state is EventsFetched) {
                      return ListView.builder(
                        padding: EdgeInsets.only(top: 8),
                        itemCount: state.events.length,
                        itemBuilder: (context, index) => AnimatedOpacity(
                          opacity: 1.0,
                          duration: Duration(milliseconds: 300 + (index * 100)),
                          child: GestureDetector(
                            onTap: () {
                              debugPrint(
                                "the event ${state.events[index].title} is printed ",
                              );
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => EventDetails(event: state.events[index]),
                                ),
                              );
                            },
                            child: buildEventItem(
                              context,
                              event: state.events[index],
                            ),
                          ),
                        ),
                      );
                    } else if (state is EventsLoading) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(height: 16),
                            Text(
                              "Loading events...",
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                              ),
                            ),
                          ],
                        ),
                      );
                    } else if (state is EventsError) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.error_outline,
                              size: 64,
                              color: Theme.of(context).colorScheme.error,
                            ),
                            SizedBox(height: 16),
                            Text(
                              "Error fetching events",
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      );
                    }
                    return const SizedBox();
                  },
                ),
                ListView.builder(
                  padding: EdgeInsets.only(top: 8),
                  itemCount: DATA.events.length,
                  itemBuilder: (context, index) =>
                      buildEventItem(context, event: DATA.events[index]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildEventItem(BuildContext context, {required EventModel event}) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.1),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Row(
        children: [
          Stack(
            children: [
              Container(
                width: 120,
                height: 130,
                color: Theme.of(context).colorScheme.primaryContainer,
                child: Image.network(
                  association.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      Icons.account_balance,
                      size: 40,
                      color: Theme.of(context).colorScheme.primary,
                    );
                  },
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    DateFormat("MMM\ndd").format(event.startDatetime),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    event.title,
                    style: subtitleStyle.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 14,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          DateFormat("E, MMM d • h:mm a").format(event.startDatetime),
                          style: bodyTextStyle.copyWith(fontSize: 13),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 14,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          event.location,
                          style: bodyTextStyle.copyWith(fontSize: 13),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Theme.of(context).colorScheme.outline,
            ),
          ),
        ],
      ),
    );
  }
}