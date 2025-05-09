// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../generated/l10n.dart';
import '../../../auth/data/models/user_model.dart';
import '../../cubit/profile_cubit.dart';
import 'item.dart';

class ProfileOptions extends StatefulWidget {
  final UserModel user;
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final TextEditingController addressController;

  const ProfileOptions({
    super.key,
    required this.user,
    required this.phoneController,
    required this.addressController,
    required this.nameController,
  });

  @override
  State<ProfileOptions> createState() => _ProfileOptionsState();
}

class _ProfileOptionsState extends State<ProfileOptions> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfileItem(
          icon: Icons.phone,
          title: widget.user.phone ?? S.of(context).change_phone_number,
          onTap: () {},
        ),
        ProfileItem(
          icon: Icons.location_on,
          title: widget.user.address ?? S.of(context).change_address,
          onTap: () {},
        ),
        ProfileItem(
          icon: Icons.settings,
          title: S.of(context).settings,
          onTap: () => GoRouter.of(context).pushNamed('settings'),
        ),
        ProfileItem(
          icon: Icons.edit,
          title: S.of(context).edit_profile,
          onTap: () async {
            final cubit = context.read<ProfileCubit>();
            await GoRouter.of(context).pushNamed(
              'editProfile',
              extra: {
                'user': widget.user,
                'phoneController': widget.phoneController,
                'addressController': widget.addressController,
                'nameController': widget.nameController,
              },
            );
            if (mounted) {
              await cubit.fetchUserData();
            }
          },
        ),
      ],
    );
  }
}
