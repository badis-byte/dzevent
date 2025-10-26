import 'package:dzevent/lib/defs.dart';
import 'package:dzevent/lib/styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:dzevent/lib/data.dart' as DATA;

class PublicAssocProfile extends StatefulWidget {
  const PublicAssocProfile({super.key});
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
  final Association association = Association(
    name: "Tech Innovators Alliance",
    imageUrl: "assets/images/public_assoc_profile.png",
    brief:
        'Lorem ipsum dolor sit amet, jksjfdkljk consectetur adipiscing elit.'
        'Nulla eget lectus augue. Etiam semper nibh vel felis dignissim vehicula. ',
    aboutUs:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'
        'Nulla eget lectus augue. Etiam semper nibh vel felis dignissim vehicula. '
        'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere '
        'cubilia curae; Maecenas finibus venenatis aliquam. Vivamus sit amet ',
    contactInfo: [
      ContactInfo(type: ContactInfoType.email, address: "lorem.gmail.com"),
      ContactInfo(type: ContactInfoType.phone, address: "0695837395"),
      ContactInfo(type: ContactInfoType.web, address: "www.lorem.com"),
    ],
  );

  final imageSize = Size(150, 150);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.share))],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: SingleChildScrollView(
          child: Column(
            children: [
              buildInfo(context),
              SizedBox(height: 16),
              buildEventTabBar(context),
            ],
          ),
        ),
      ),
    );
  }

  Column buildInfo(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(shape: BoxShape.circle),
          clipBehavior: Clip.antiAlias,
          width: imageSize.width,
          height: imageSize.height,
          child: Image.asset(association.imageUrl, fit: BoxFit.fill),
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
            child: Text("Follow Association"),
          ),
        ),
        SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: Text(
            "About us",
            style: headingStyle,
            textAlign: TextAlign.left,
          ),
        ),
        Text(association.aboutUs, style: bodyTextStyle),
        SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: Text(
            "Contact Information",
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

  Widget buildEventTabBar(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Container(
        color: Theme.of(context).colorScheme.surfaceContainer,
        child: Column(
          children: [
            TabBar(
              tabs: [
                Tab(text: "Upcoming events"),
                Tab(text: "Past events"),
              ],
            ),
            SizedBox(
              height: 300,
              child: TabBarView(
                children: [
                  ListView.builder(
                    itemCount: DATA.events.length,
                    itemBuilder: (context, index) =>
                        buildEventItem(context, event: DATA.events[index]),
                  ),
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

  Widget buildEventItem(context, {required Event event}) {
    final imageSize = const Size(150, 150);

    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: Row(
        children: [
          SizedBox(
            width: imageSize.width,
            height: imageSize.height,
            child: Image.asset(event.imageUrl),
          ),
          SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(DateFormat("E, MMMd.").add_j().format(event.datetime)),
              Text(event.title, style: subtitleStyle),
              Text(event.location, style: bodyTextStyle),
            ],
          ),
        ],
      ),
    );
  }
}
