// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../generated/l10n.dart';
import '../../../../auth/data/models/user_model.dart';
import 'item.dart';

class ProfileOptions extends StatelessWidget {
  final UserModel user;
  const ProfileOptions({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfileItem(
          icon: Icons.phone,
          title: user.phone ?? S.of(context).change_phone_number,
          onTap: () {},
        ),
        ProfileItem(
          icon: Icons.location_on,
          title: user.address ?? S.of(context).change_address,
          onTap: () {},
        ),
        ProfileItem(
          icon: Icons.edit,
          title: S.of(context).edit_profile,
          onTap: () async {
            await GoRouter.of(context).pushNamed('editProfile', extra: user);
          },
        ),
        ProfileItem(
          icon: Icons.settings,
          title: S.of(context).settings,
          onTap: () => GoRouter.of(context).pushNamed('settings'),
        ),
      ],
    );
  }
}
