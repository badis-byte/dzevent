import 'package:dzevent/logic/cubits/auth/auth_cubit.dart';
import 'package:dzevent/logic/cubits/auth/auth_states.dart';
import 'package:dzevent/presentation/screens/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileHeader extends StatefulWidget {
  const ProfileHeader({super.key});

  @override
  State<ProfileHeader> createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<AccountCubit>().getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountCubit, AccountState>(
      builder: (context, state) {
        if (state is AccountLoading) {
          return CircularProgressIndicator();
        }
        if (state is AccountError) {
          return Text(state.error);
        }
        if (state is AccountGuest) {
          return const Text("Guest");
        }
        if (state is UserFetched) {
          final user = state.user;
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 50,
                child: Image.network(
                  user.profilePicture,
                  errorBuilder: (context, error, stackTrace) =>
                      Text("Invalid image"),
                ),
              ),
              SizedBox(width: 16),
              IntrinsicHeight(
                child: Column(
                  children: [
                    Text(state.user.name),
                    SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(
                          context,
                        ).pushReplacement(UserProfileScreen.route());
                      },
                      child: Text("View Profile"),
                    ),
                  ],
                ),
              ),
            ],
          );
        }
        return Text("unexpected state: ${state.runtimeType}");
      },
    );
  }
}
