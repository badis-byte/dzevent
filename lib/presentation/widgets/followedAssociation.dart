import 'package:dzevent/data/models/assoc_model.dart';
import 'package:dzevent/presentation/screens/public_assoc_profile.dart';
import 'package:flutter/material.dart';

class FollowedAssociationCard extends StatelessWidget {
  final AssociationModel association;

  const FollowedAssociationCard({required this.association, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => PublicAssocProfile(asso: association),
            ),
          );
        },
        leading: CircleAvatar(
          backgroundImage: NetworkImage(association.profilePicture),
        ),
        title: Text(association.name),
        subtitle: Text(association.bio ?? ""),
        trailing: Icon(Icons.chevron_right),
      ),
    );
  }
}
