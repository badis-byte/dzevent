import 'package:dzevent/logic/cubits/auth/auth_cubit.dart';
import 'package:dzevent/logic/cubits/auth/auth_states.dart';
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
          return Text("User: ${state.user.name}");
        }
        return Text("unexpected state: ${state.runtimeType}");
      },
    );
  }
}
