import 'package:flutter/material.dart';
import 'package:green_city/featuers/home/presentation/views/Announcements/widgets/user_announs.dart';
import 'package:green_city/featuers/home/presentation/views/Announcements/widgets/institutions_announs.dart';
import 'package:green_city/featuers/home/presentation/views/Announcements/widgets/announs_taps.dart';
import 'package:green_city/generated/l10n.dart';

class AnnounsView extends StatefulWidget {
  const AnnounsView({super.key});

  @override
  State<AnnounsView> createState() => _AnnounsViewState();
}

class _AnnounsViewState extends State<AnnounsView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).announcements)),
      body: Column(
        children: [
          AnnounsTabs(controller: _tabController),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                const UserAnnouns(),

                const InstitutionsAnnouns(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
