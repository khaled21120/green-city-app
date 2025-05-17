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
          icon: Icons.phone_rounded,
          title: S.of(context).phone_number,
          value: user.phone ?? S.of(context).not_provided,
          onTap: () => _navigateToEditPhone(context),
          showTrailingIcon: false,
        ),
        ProfileItem(
          icon: Icons.location_on_rounded,
          title: S.of(context).address,
          value: user.address ?? S.of(context).not_provided,
          onTap: () => _navigateToEditAddress(context),
          showTrailingIcon: false,
        ),
        const Divider(height: 24, indent: 16, endIndent: 16),
        ProfileItem(
          icon: Icons.edit_rounded,
          title: S.of(context).edit_profile,
          onTap: () => _navigateToEditProfile(context),
        ),
        ProfileItem(
          icon: Icons.settings_rounded,
          title: S.of(context).settings,
          onTap: () => _navigateToSettings(context),
        ),
      ],
    );
  }

  void _navigateToEditPhone(BuildContext context) async {
    final result = await GoRouter.of(
      context,
    ).pushNamed('editPhone', extra: user);
    if (result == true) {
      // Handle successful update if needed
    }
  }

  void _navigateToEditAddress(BuildContext context) async {
    final result = await GoRouter.of(
      context,
    ).pushNamed('editAddress', extra: user);
    if (result == true) {
      // Handle successful update if needed
    }
  }

  void _navigateToEditProfile(BuildContext context) {
    GoRouter.of(context).pushNamed('editProfile', extra: user);
  }

  void _navigateToSettings(BuildContext context) {
    GoRouter.of(context).pushNamed('settings');
  }
}
