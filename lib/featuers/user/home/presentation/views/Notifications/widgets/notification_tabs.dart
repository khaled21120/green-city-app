// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:green_city/core/themes/light_theme.dart';

import '../../../../../../../core/utils/text_style.dart';
import '../../../../../../../generated/l10n.dart';

class NotificationTabs extends StatelessWidget {
  const NotificationTabs({super.key, required this.tabController});
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final strings = S.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: MyColors.primaryDark.withOpacity(0.9),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 10,
              spreadRadius: 1,
              offset: const Offset(0, 4),
            ),
          ],
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              MyColors.primaryDark,
              MyColors.primaryDark.withOpacity(0.8),
            ],
          ),
        ),
        child: TabBar(
          controller: tabController,
          dividerHeight: 0,
          indicator: const UnderlineTabIndicator(
            borderSide: BorderSide(width: 3, color: MyColors.white),
            insets: EdgeInsets.symmetric(horizontal: 24),
          ),
          indicatorWeight: 0, // Remove default indicator
          labelColor: MyColors.white,
          unselectedLabelColor: MyColors.grey.withOpacity(0.7),
          labelStyle: MyStyle.title16(
            context,
          ).copyWith(fontWeight: FontWeight.w600, letterSpacing: 0.5),
          unselectedLabelStyle: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w500,
          ),
          tabs: [
            Tab(
              icon: const Icon(Icons.lock, size: 20),
              text: strings.private,
              iconMargin: const EdgeInsets.only(bottom: 4),
            ),
            Tab(
              icon: const Icon(Icons.public, size: 20),
              text: strings.public,
              iconMargin: const EdgeInsets.only(bottom: 4),
            ),
          ],
          splashBorderRadius: BorderRadius.circular(30),
          overlayColor: WidgetStateProperty.resolveWith<Color?>((
            Set<WidgetState> states,
          ) {
            if (states.contains(WidgetState.pressed)) {
              return MyColors.white.withOpacity(0.1);
            }
            return null;
          }),
        ),
      ),
    );
  }
}
