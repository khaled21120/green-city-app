import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:green_city/generated/l10n.dart';

import '../../user/profile/cubit/profile_cubit.dart';
import 'widgets/admin_body.dart';

class AdminProfilePage extends StatelessWidget {
  const AdminProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ProfileCubit>().fetchUserData();
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).profile)),
      body: const AdminProfileView(),
    );
  }
}
