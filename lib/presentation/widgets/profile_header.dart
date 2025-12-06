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
          return Column(
            children: [
              SizedBox(height: 20,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 61,
                    child: Image.asset(
                      user.profilePicture,
                      errorBuilder: (context, error, stackTrace) =>
                          Text("Invalid image"),
                    ),
                  ),
                  SizedBox(width: 16),
                  IntrinsicHeight(
                    child: Column(
                      children: [
                        Text(user.name, style: TextStyle(fontSize: 20, color: Colors.black, height: 1.0),),
                        Text(user.email, style: TextStyle(fontSize: 15, color: Colors.blueGrey, height: 1.0),),
                        SizedBox(height: 8),
                      ],
                    ),
                  ),
                  SizedBox(width: 60),
                ],
                
              ),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.black87, width: 1.4),
                  padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pushReplacement(UserProfileScreen.route());
                },
                child: Text(
                  "View Profile",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
              ),


            ],
          );
        }
        if (state is UserFetched) {
          final user = state.user;
          return Column(
            children: [
              SizedBox(height: 20,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 61,
                    child: Image.asset(
                      user.profilePicture,
                      errorBuilder: (context, error, stackTrace) =>
                          Text("Invalid image"),
                    ),
                  ),
                  SizedBox(width: 16),
                  IntrinsicHeight(
                    child: Column(
                      children: [
                        Text(user.name, style: TextStyle(fontSize: 20, color: Colors.black, height: 1.0),),
                        Text(user.email, style: TextStyle(fontSize: 15, color: Colors.blueGrey, height: 1.0),),
                        SizedBox(height: 8),
                      ],
                    ),
                  ),
                  SizedBox(width: 60),
                ],
                
              ),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.black87, width: 1.4),
                  padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pushReplacement(UserProfileScreen.route());
                },
                child: Text(
                  "View Profile",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
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
