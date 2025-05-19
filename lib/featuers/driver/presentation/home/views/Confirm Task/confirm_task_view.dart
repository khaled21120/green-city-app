import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:green_city/core/utils/button.dart';
import 'package:green_city/core/utils/text_felid.dart';
import 'package:green_city/featuers/driver/cubits/Driver%20Reports/driver_reports_cubit.dart';

import '../../../../../../generated/l10n.dart';

class ConfirmTaskView extends StatefulWidget {
  const ConfirmTaskView({super.key});

  @override
  State<ConfirmTaskView> createState() => _ConfirmTaskViewState();
}

class _ConfirmTaskViewState extends State<ConfirmTaskView> {
  final r = TextEditingController();
  final s = TextEditingController();
  final f = TextEditingController();
  final d = TextEditingController();

  @override
  void dispose() {
    r.dispose();
    s.dispose();
    f.dispose();
    d.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).confirm_password)),
      body: Column(
        children: [
          MyTextFelid(label: '', controller: r),
          MyTextFelid(label: '', controller: r),
          MyTextFelid(label: '', controller: r),
          MyTextFelid(label: '', controller: r),
          MyTextFelid(label: '', controller: r),
          MyButton(
            text: S.of(context).send,
            onTap: () {
              // context.read<DriverReportsCubit>().completeTask(id: 2);
              // context.read<DriverReportsCubit>().sendDriverReports(data: {});
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
