import 'package:dzevent/lib/defs.dart';
import 'package:dzevent/lib/styles.dart';
import 'package:flutter/material.dart';

class PublicAssocProfile extends StatelessWidget {
  PublicAssocProfile({super.key});
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

  static const contactIcon = {
    ContactInfoType.email: Icons.email,
    ContactInfoType.phone: Icons.phone,
    ContactInfoType.web: Icons.web,
  };

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
                  leading: Icon(contactIcon[contact.type]),
                  title: Text(contact.address),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
