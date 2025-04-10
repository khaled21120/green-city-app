import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:green_city/core/functions/helper.dart';
import 'package:green_city/generated/l10n.dart';

import '../../../../core/utils/text_style.dart';
import '../../../auth/presentation/cubits/Auth/auth_cubit.dart';
import 'my_list_tile.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: SingleChildScrollView(
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

              // Polls
              MyListTile(
                title: S.of(context).polls,
                icon: Icons.poll_rounded,
                onTap: () => GoRouter.of(context).pushNamed('polls'),
              ),

              // Notifications
              MyListTile(
                title: S.of(context).notifications,
                icon: Icons.notifications_rounded,
                onTap: () => GoRouter.of(context).pushNamed('notifications'),
              ),

              // About Us
              MyListTile(
                title: S.of(context).about_us,
                icon: Icons.info_rounded,
                onTap: () => GoRouter.of(context).pushNamed('aboutUs'),
              ),

              MyListTile(
                title: S.of(context).assistant,
                icon: Icons.chat,
                onTap:
                    () => GoRouter.of(
                      context,
                    ).pushNamed('assistantPage', extra: Helper.getUser()),
              ),

              // Logout
              MyListTile(
                title: S.of(context).sign_out,
                icon: Icons.logout_rounded,
                onTap: () {
                  context.read<AuthCubit>().logOut();
                  GoRouter.of(context).goNamed('intro');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
