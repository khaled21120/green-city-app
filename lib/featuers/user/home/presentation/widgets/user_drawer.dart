import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:green_city/generated/l10n.dart';

import '../../../../../core/utils/text_style.dart';
import '../../../../auth/cubits/Auth/auth_cubit.dart';
import 'my_list_tile.dart';

class UserDrawer extends StatelessWidget {
  const UserDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          spacing: 30,
          children: [
            // Drawer Header
            DrawerHeader(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Text('Green City', style: MyStyle.title30(context)),
            ),

            // FAQs
            MyListTile(
              title: S.of(context).faqs,
              icon: Icons.question_mark_rounded,
              onTap: () => GoRouter.of(context).pushNamed('FAQs'),
            ),

            // Announcements
            MyListTile(
              title: S.of(context).announcements,
              icon: Icons.phone_android_rounded,
              onTap: () => GoRouter.of(context).pushNamed('announcements'),
            ),
            MyListTile(
              title: S.of(context).admin,
              icon: Icons.admin_panel_settings,
              onTap: () => GoRouter.of(context).pushNamed('adminHome'),
            ),

            // About Us
            MyListTile(
              icon: Icons.info_rounded,
              title: S.of(context).about_us,
              onTap: () => GoRouter.of(context).pushNamed('aboutUs'),
            ),
            const Spacer(),
            const Divider(),

            // Logout
            MyListTile(
              title: S.of(context).sign_out,
              icon: Icons.logout_rounded,
              onTap: () => context.read<AuthCubit>().logOut(),
            ),
          ],
        ),
      ),
    );
  }
}
