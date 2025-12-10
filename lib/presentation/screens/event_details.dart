import 'package:dzevent/data/models/assoc_model.dart';
import 'package:dzevent/data/models/event_model.dart';
import 'package:dzevent/lib/styles.dart';
import 'package:dzevent/l10n/app_localizations.dart';
import 'package:dzevent/logic/cubits/auth/auth_cubit.dart';
import 'package:dzevent/logic/cubits/auth/auth_states.dart';
import 'package:dzevent/presentation/screens/public_assoc_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class EventDetails extends StatefulWidget {
  final EventModel event;
  const EventDetails({super.key, required this.event});

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  final double _imageHeight = 270;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
  }

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
            child: Image.network(
              widget.event.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  widget.event.imageUrl, // fallback image
                  fit: BoxFit.cover,
                );
              },
            ),
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
                        Flexible(
                          child: Text(widget.event.title, style: headingStyle),
                        ),
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
                          DateFormat.MMMEd().format(widget.event.startDatetime),
                          style: subtitleStyle,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.location_on),
                        const SizedBox(width: 4),
                        Text(widget.event.location, style: subtitleStyle),
                      ],
                    ),
                    const Divider(),
                    BlocBuilder<AccountCubit, AccountState>(
                      builder: (context, state) {
                        if (state is AssociationFetched) {
                          return AssociatonLink(association: state.association);
                        }
                        return Text("can't fetch association");
                      },
                    ),

                    const Divider(),
                    Text(loc.aboutThisEvent, style: subtitleStyle),
                    const SizedBox(height: 8),
                    Text(widget.event.description, textAlign: TextAlign.start),
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
  final AssociationModel association;
  final double associationIconHeight = 70;
  final double associationIconWidth = 70;
  const AssociatonLink({super.key, required this.association});

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
          child: Image.network(
            association.profilePicture,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Icon(Icons.account_balance); // fallback image
            },
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(association.name, style: subtitleStyle),
            Text(loc.viewProfile, textAlign: TextAlign.start),
          ],
        ),
        const Spacer(),
        IconButton(
          icon: const Icon(Icons.arrow_forward),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => PublicAssocProfile(asso: association),
              ),
            );
          },
        ),
      ],
    );
  }
}
