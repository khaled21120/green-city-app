import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:green_city/generated/l10n.dart';

import '../../../../user/presentation/cubits/profile/profile_cubit.dart';
import 'widgets/admin_body.dart';

class AdminProfileview extends StatelessWidget {
  const AdminProfileview({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ProfileCubit>().fetchUserData();
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).profile)),
      body: const AdminProfileBody(),
    );
  }
}
