import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:green_city/featuers/user/presentation/cubits/User%20Report%20Cubit/user_reports_cubit.dart';

import '../../../../../../../core/widgets/error_widget.dart';
import '../../../../../../../generated/l10n.dart';
import '../../widgets/shimmer_grid.dart';
import 'widgets/reports_item.dart';

class MyReportsView extends StatelessWidget {
  const MyReportsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).my_reports)),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: BlocBuilder<UserReportsCubit, ReportsState>(
          builder: (context, state) {
            if (state is ReportsLoading) {
              return const ShimmerGridItem(aspectratio: 0.75);
            } else if (state is ReportsError) {
              return ErrorsWidget(
                message: state.message,
                onPressed:
                    () async => context.read<UserReportsCubit>().fetchReports(),
              );
            } else if (state is FetchReportsSuccess) {
              if (state.announsList.isEmpty) {
                return Center(child: Text(S.of(context).no_reports));
              }
              return GridView.builder(
                itemCount: state.announsList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (context, index) {
                  final item = state.announsList[index];
                  return AnnounsItem(
                    item: item,
                    color: getColor(item.status ?? ''),
                  );
                },
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}

Color getColor(String status) {
  switch (status) {
    case 'Approved':
      return Colors.green;
    case 'Pending':
      return Colors.orangeAccent;
    case 'Rejected':
      return Colors.red;
    case 'Completed':
      return Colors.black;
    case 'Assigned':
      return Colors.teal;
    default:
      return Colors.grey;
  }
}
