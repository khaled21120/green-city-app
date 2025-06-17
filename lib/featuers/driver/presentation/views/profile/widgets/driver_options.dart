import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../generated/l10n.dart';
import '../../../../../auth/data/models/user_model.dart';
import '../../../../../user/presentation/views/profile/widgets/item.dart';

class DriverProfileOptions extends StatelessWidget {
  final UserModel user;
  const DriverProfileOptions({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfileItem(
          icon: Icons.phone_rounded,
          title: S.of(context).phone_number,
          value: user.phone ?? S.of(context).not_provided,
          onTap: () => {},
          showTrailingIcon: false,
        ),
        ProfileItem(
          icon: Icons.location_on_rounded,
          title: S.of(context).address,
          value: user.address ?? S.of(context).not_provided,
          onTap: () => {},
          showTrailingIcon: false,
        ),
        ProfileItem(
          icon: Icons.fire_truck_rounded,
          title: S.of(context).truck_number,
          value: user.truckNumber ?? S.of(context).not_provided,
          onTap: () => {},
          showTrailingIcon: false,
        ),
        ProfileItem(
          icon: Icons.badge_rounded,
          title: S.of(context).license_number,
          value: user.licenseNumber ?? S.of(context).not_provided,
          onTap: () => {},
          showTrailingIcon: false,
        ),
        ProfileItem(
          icon: Icons.calendar_today_rounded,
          title: S.of(context).license_expiry_date,
          value: user.licenseExpiryDate ?? S.of(context).not_provided,
          onTap: () => {},
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

  void _navigateToEditProfile(BuildContext context) {
    GoRouter.of(context).pushNamed('editDriverProfile', extra: user);
  }

  void _navigateToSettings(BuildContext context) {
    GoRouter.of(context).pushNamed('settings');
  }
}
