import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:green_city/generated/l10n.dart';

import '../../../../core/utils/text_style.dart';
import 'my_list_tile.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

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
              onTap: () => GoRouter.of(context).push('/FAQs'),
            ),

            // Announcements
            MyListTile(
              title: S.of(context).announcements,
              icon: Icons.phone_android_rounded,
              onTap: () => GoRouter.of(context).push('/announcements'),
            ),

            // About Us
            MyListTile(
              title: S.of(context).about_us,
              icon: Icons.info_rounded,
              onTap: () => GoRouter.of(context).push('/aboutUs'),
            ),
            const Spacer(),
            
            // Logout
            MyListTile(
              title: S.of(context).sign_out,
              icon: Icons.logout_rounded,
              onTap: () {

              },
            ),
          ],
        ),
      ),
    );
  }
}
