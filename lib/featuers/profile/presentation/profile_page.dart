import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/services/get_it_service.dart';
import '../cubit/profile_cubit.dart';
import 'widgets/body.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ProfileCubit>()..fetchUserData(),
      child: const ProfileView(),
    );
  }
}
