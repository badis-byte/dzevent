import 'package:dzevent/data/models/event_model.dart';
import 'package:dzevent/lib/styles.dart';
import 'package:dzevent/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventDetails extends StatelessWidget {
  final double _imageHeight = 270;
  final EventModel event;
  const EventDetails({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

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
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(child: Text(event.title, style: headingStyle)),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.share),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.favorite),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.calendar_today),
                        const SizedBox(width: 4),
                        Text(
                          DateFormat.MMMEd().format(event.startDatetime),
                          style: subtitleStyle,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.location_on),
                        const SizedBox(width: 4),
                        Text(event.location, style: subtitleStyle),
                      ],
                    ),
                    const Divider(),
                    AssociatonLink(associatonId: event.associationId),
                    const Divider(),
                    Text(loc.aboutThisEvent, style: subtitleStyle),
                    const SizedBox(height: 8),
                    Text(event.description, textAlign: TextAlign.start),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: getPrimaryBtnStyle(context: context),
                        child: Text(loc.showInterest),
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
    final loc = AppLocalizations.of(context)!;

    return Row(
      children: [
        Container(
          margin: const EdgeInsets.only(right: 16),
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(shape: BoxShape.circle),
          width: associationIconWidth,
          height: associationIconHeight,
          // child: Image.asset(associaton.imageUrl, fit: BoxFit.fill),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(associatonId.toString(), style: subtitleStyle),
            Text(loc.viewProfile, textAlign: TextAlign.start),
          ],
        ),
        const Spacer(),
        IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_forward)),
      ],
    );
  }
}
