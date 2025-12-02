import 'package:dzevent/lib/defs.dart';
import 'package:dzevent/lib/styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:dzevent/data/fake_data.dart' as DATA;

class EventDetails extends StatelessWidget {
  final double _imageHeight = 270;
  final event = DATA.event1;
  EventDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: _imageHeight,
            child: Image.asset(event.imageUrl, fit: BoxFit.fill),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  spacing: 16,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(child: Text(event.title, style: headingStyle)),
                        IconButton(onPressed: () {}, icon: Icon(Icons.share)),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.favorite),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.calendar_today),
                        Text(
                          DateFormat.MMMEd().format(event.startDatetime),
                          style: subtitleStyle,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.location_on),
                        Text(event.location, style: subtitleStyle),
                      ],
                    ),
                    Divider(),
                    AssociatonLink(associatonId: event.associationId),
                    Divider(),
                    Text("About this event", style: subtitleStyle),
                    Text(event.description, textAlign: TextAlign.start),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: getPrimaryBtnStyle(context: context),
                        child: Text("Show interest"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AssociatonLink extends StatelessWidget {
  final int associatonId;
  final double associationIconHeight = 70;
  final double associationIconWidth = 70;
  const AssociatonLink({super.key, required this.associatonId});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.only(right: 16),
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(shape: BoxShape.circle),
          width: associationIconWidth,
          height: associationIconHeight,
          // child: Image.asset(associaton.imageUrl, fit: BoxFit.fill),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(associatonId.toString(), style: subtitleStyle),
            Text("View profile", textAlign: TextAlign.start),
          ],
        ),
        Spacer(),
        IconButton(onPressed: () {}, icon: Icon(Icons.arrow_forward)),
      ],
    );
  }
}
