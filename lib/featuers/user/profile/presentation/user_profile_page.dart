import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../generated/l10n.dart';
import '../cubit/profile_cubit.dart';
import 'widgets/body.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ProfileCubit>().fetchUserData();
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).profile)),
      body: const UserProfileBody(),
    );
  }
}
