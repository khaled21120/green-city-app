// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/functions/helper.dart';
import '../../../../core/services/get_it_service.dart';
import '../../../../generated/l10n.dart';
import '../../../auth/data/models/user_model.dart';
import '../../cubit/profile_cubit.dart';
import 'item.dart';

class ProfileOptions extends StatelessWidget {
  final UserModel user;
  final TextEditingController phoneController;
  final TextEditingController addressController;

  const ProfileOptions({
    super.key,
    required this.user,
    required this.phoneController,
    required this.addressController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfileItem(
          icon: Icons.phone,
          title: user.phone ?? S.of(context).change_phone_number,
          onTap: () {
            Helper.showAlert(
              context: context,
              onTap: () async {
                if (phoneController.text.isNotEmpty) {
                  await getIt<ProfileCubit>().updateData(
                    data: {'Phone': phoneController.text},
                    isImage: false,
                  );
                  Navigator.pop(context);
                }
                phoneController.clear();
              },
              title: S.of(context).phone_number,
              controller: phoneController,
            );
          },
        ),
        ProfileItem(
          icon: Icons.location_on,
          title: user.address ?? S.of(context).change_address,
          onTap: () {
            Helper.showAlert(
              context: context,
              onTap: () async {
                if (addressController.text.isNotEmpty) {
                  await getIt<ProfileCubit>().updateData(
                    data: {'Address': addressController.text},
                    isImage: false,
                  );
                  Navigator.pop(context);
                }
                addressController.clear();
              },
              title: S.of(context).address,
              controller: addressController,
            );
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