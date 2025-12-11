import 'package:flutter/material.dart';

class AssociationInterestRequestsPage extends StatefulWidget {
static MaterialPageRoute route() =>
      MaterialPageRoute(builder: (context) => AssociationInterestRequestsPage());
  static const String pageRoute = "association-interests";

  const AssociationInterestRequestsPage({super.key});

  @override
  State<AssociationInterestRequestsPage> createState() => _AssociationInterestRequestsPageState();
}

class _AssociationInterestRequestsPageState extends State<AssociationInterestRequestsPage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}