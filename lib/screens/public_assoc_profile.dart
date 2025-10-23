import 'package:dzevent/lib/defs.dart';
import 'package:dzevent/lib/styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:dzevent/lib/data.dart' as DATA;

class _EventItem extends StatelessWidget {
  final Event _event;
  const _EventItem({super.key, required Event event}) : _event = event;
  final imageSize = const Size(150, 150);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: imageSize.width,
          height: imageSize.height,
          child: Image.asset(_event.imageUrl),
        ),
        SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(DateFormat("E, MMMd.").add_j().format(_event.datetime)),
            Text(_event.title, style: subtitleStyle),
            Text(_event.location, style: bodyTextStyle),
          ],
        ),
      ],
    );
  }
}

class PublicAssocProfile extends StatefulWidget {
  const PublicAssocProfile({super.key});
  static const contactIcon = {
    ContactInfoType.email: Icons.email,
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
              DefaultTabController(
                initialIndex: 0,
                length: 2,
                child: Container(
                  color: Colors.grey,
                  child: Column(
                    children: [
                      TabBar(
                        tabs: [
                          Tab(text: "Upcoming events"),
                          Tab(text: "Past events"),
                        ],
                      ),
                      SizedBox(
                        height: 100,
                        child: TabBarView(
                          children: [
                            ListView.builder(
                              itemCount: DATA.events.length,
                              itemBuilder: (context, index) =>
                                  _EventItem(event: DATA.events[index]),
                            ),
                            Text("Past events content"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
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
        Text("About us", style: headingStyle, textAlign: TextAlign.start),
        Text(association.aboutUs, style: bodyTextStyle),
        Text(
          "Contact Information",
          style: headingStyle,
          textAlign: TextAlign.start,
        ),
        for (final contact in association.contactInfo)
          ListTile(
            leading: Icon(PublicAssocProfile.contactIcon[contact.type]),
            title: Text(contact.address),
          ),
      ],
    );
  }
}
