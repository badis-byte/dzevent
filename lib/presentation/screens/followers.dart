import 'package:dzevent/data/models/assoc_model.dart';
import 'package:dzevent/logic/cubits/auth/auth_cubit.dart';
import 'package:dzevent/logic/cubits/auth/auth_states.dart';
import 'package:dzevent/logic/cubits/followers/followers_cubits.dart';
import 'package:dzevent/logic/cubits/followers/followers_state.dart';
import 'package:dzevent/presentation/widgets/followedAssociation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FollowedAssociationsScreen extends StatefulWidget {
  static MaterialPageRoute route() =>
      MaterialPageRoute(builder: (context) => FollowedAssociationsScreen());
  static const String pageRoute = "followed-feed";

  const FollowedAssociationsScreen({super.key});

  @override
  State<FollowedAssociationsScreen> createState() => _FollowedAssociationsScreenState();
}

class _FollowedAssociationsScreenState extends State<FollowedAssociationsScreen> {
  int? userId;

  @override
  void initState() {
    super.initState();

    final authState = context.read<AccountCubit>().state;

    if (authState is UserFetched) {
      userId = authState.user.id;
    } else {
      // Handle the case when the user is not fetched or not logged in
      userId = null;
    }

    if (userId != null) {
      context.read<FollowCubit>().getFollowedAssociations(userId!);
    } else {
      // Optionally handle the scenario where userId is null
      debugPrint("User not logged in or userId is null.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Followed Associations"),
      ),
      body: BlocBuilder<FollowCubit, FollowState>(
        builder: (context, state) {
          if (state is FollowLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (state is FollowListFetched) {
            if (state.followedAssociationIds.isEmpty) {
              return Center(child: Text("You are not following any associations"));
            }

            return ListView.builder(
              itemCount: state.followedAssociationIds.length,
              itemBuilder: (context, index) {
                final assocId = state.followedAssociationIds[index];
                return FutureBuilder<AssociationModel>(
                  future: context.read<AccountCubit>().getFollowedAssociation(assocId),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (!snapshot.hasData) {
                      return Center(child: Text("Failed to load association."));
                    }

                    final association = snapshot.data!;
                    return FollowedAssociationCard(association: association);
                  },
                );
              },
            );
          }

          if (state is FollowError) {
            return Center(child: Text("Error: ${state.message}"));
          }

          // Default empty state
          return Center(child: Text("No associations found."));
        },
      ),
    );
  }
}
