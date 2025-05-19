import 'package:flutter/material.dart';
import 'package:green_city/featuers/user/presentation/views/home/views/Reports/widgets/user_reports.dart';
import 'package:green_city/featuers/user/presentation/views/home/views/Reports/widgets/institutions_reports.dart';
import 'package:green_city/featuers/user/presentation/views/home/views/Reports/widgets/reports_taps.dart';
import 'package:green_city/generated/l10n.dart';

class ReportsView extends StatefulWidget {
  const ReportsView({super.key});

  @override
  State<ReportsView> createState() => _ReportsViewState();
}

class _ReportsViewState extends State<ReportsView>
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
      appBar: AppBar(title: Text(S.of(context).reports)),
      body: Column(
        children: [
          AnnounsTabs(controller: _tabController),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [const UserReports(), const InstitutionsReports()],
            ),
          ),
        ],
      ),
    );
  }
}
