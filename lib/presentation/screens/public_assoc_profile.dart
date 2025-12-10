import 'package:dzevent/data/models/assoc_model.dart';
import 'package:dzevent/l10n/app_localizations.dart';
import 'package:dzevent/data/models/event_model.dart';
import 'package:dzevent/lib/defs.dart';
import 'package:dzevent/lib/styles.dart';
import 'package:dzevent/logic/cubits/events/events_cubit.dart';
import 'package:dzevent/logic/cubits/events/events_state.dart';
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
  final imageSize = Size(150, 150);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    association = Association(
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
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    context.read<EventsCubit>().getAllEventsByUser(widget.asso.id!);

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

  Column buildInfo(BuildContext context, AppLocalizations loc) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(shape: BoxShape.circle),
          clipBehavior: Clip.antiAlias,
          width: imageSize.width,
          height: imageSize.height,
          child: Image.network(
            association.imageUrl,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Icon(Icons.account_balance); // fallback image
            },
          ),
        ),
        Text(association.name, style: headingStyle),
        Text(
          association.brief,
          style: subtitleStyle,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {},
            style: getPrimaryBtnStyle(context: context),
            child: Text(loc.followAssociation),
          ),
        ),
        SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: Text(
            loc.aboutUs,
            style: headingStyle,
            textAlign: TextAlign.left,
          ),
        ),
        Text(association.aboutUs, style: bodyTextStyle),
        SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: Text(
            loc.contactInformation,
            style: headingStyle,
            textAlign: TextAlign.left,
          ),
        ),
        for (final contact in association.contactInfo)
          ListTile(
            contentPadding: EdgeInsets.all(0),
            leading: Container(
              padding: EdgeInsets.all(8.0),
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
      initialIndex: 0,
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
                  // First tab: events from Bloc
                  BlocBuilder<EventsCubit, EventsState>(
                    builder: (context, state) {
                      if (state is EventsFetched) {
                        return ListView.builder(
                          itemCount: state.events.length,
                          itemBuilder: (context, index) => GestureDetector(
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
                        );
                      } else if (state is EventsLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is EventsError) {
                        return Center(child: Text("Error fetching events"));
                      }
                      return const SizedBox(); // fallback for other states
                    },
                  ),

                  // Second tab: static events
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

  Widget buildEventItem(BuildContext context, {required EventModel event}) {
    final imageSize = const Size(150, 150);

    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: Row(
        children: [
          SizedBox(
            width: imageSize.width,
            height: imageSize.height,
            child: Image.network(
              association.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Icon(Icons.account_balance); // fallback image
              },
            ),
          ),
          SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(DateFormat("E, MMMd.").add_j().format(event.startDatetime)),
              Text(event.title, style: subtitleStyle),
              Text(event.location, style: bodyTextStyle),
            ],
          ),
        ],
      ),
    );
  }
}
