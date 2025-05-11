import 'package:flutter/material.dart';

import '../../../../../core/utils/text_style.dart';
import '../../../../../generated/l10n.dart';
import '../../../../auth/data/models/user_model.dart';
import 'profile_picture.dart';

class ProfileHeader extends StatelessWidget {
  final UserModel user;
  const ProfileHeader({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfilePicture(imageUrl: user.profileImage),
        const SizedBox(height: 10),
        Text(
          user.name ?? S.of(context).user_name,
          style: MyStyle.title25(context),
        ),
        Text(
          user.email ?? S.of(context).email_address,
          style: MyStyle.title16(context),
        ),
      ],
    );
  }
}
