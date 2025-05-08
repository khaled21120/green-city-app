import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../../core/themes/light_theme.dart';
import '../../../generated/l10n.dart';
import '../../profile/presentation/profile_page.dart';
import 'views/chellanges/chellange_page.dart';
import 'widgets/drawer.dart';
import 'widgets/home_body.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final pageController = PageController();
    List<Widget> pages = [
      const UserHomeScreen(),
      const ChellangePage(),
      const ProfilePage(),
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('Green City'), centerTitle: true),
      drawer: const MyDrawer(),
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: pages,
      ),
      bottomNavigationBar: GNav(
        curve: Curves.easeInOut,
        backgroundColor:
            Theme.of(context).colorScheme.primary, // Adapts to theme
        tabBackgroundColor:
            Theme.of(context).colorScheme.tertiary, // Light/Dark mode aware
        color: MyColors.black, // Contrast for active tab,
        activeColor: MyColors.white, // Contrast for active tab
        gap: 5,
        padding: const EdgeInsets.all(15),
        onTabChange: (idx) => pageController.jumpToPage(idx),
        tabs: [
          GButton(icon: Icons.home, text: S.of(context).home),
          GButton(icon: Icons.event_available, text: S.of(context).activities),
          GButton(icon: Icons.person, text: S.of(context).profile),
        ],
      ),
    );
  }
}

/*  CurvedNavigationBar(
        animationCurve: Curves.easeInOut,
        index: 1,
        onTap: (idx) => pageController.jumpToPage(idx),
        backgroundColor: MyColors.scaffold,
        animationDuration: const Duration(milliseconds: 500),
        buttonBackgroundColor: MyColors.scaffold,
        color: MyColors.primary,
        items: [
          const Icon(Icons.search),
          const Icon(Icons.home),
          const Icon(Icons.person),
        ],
      ), */
/*GNav(
        curve: Curves.easeInOut,
        backgroundColor:
            Theme.of(context).colorScheme.primary, // Adapts to theme
        tabBackgroundColor:
            Theme.of(context).colorScheme.tertiary, // Light/Dark mode aware
        color: MyColors.black, // Contrast for active tab,
        activeColor: MyColors.white, // Contrast for active tab
        gap: 5,
        padding: const EdgeInsets.all(20),
        onTabChange: (idx) => pageController.jumpToPage(idx),
        tabs: [
          GButton(icon: Icons.home, text: S.of(context).home),
          GButton(icon: Icons.event_available, text: S.of(context).activities),
          GButton(icon: Icons.person, text: S.of(context).profile),
        ],
      ), */
