import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:green_city/featuers/user/home/cubits/User%20Report%20Cubit/user_reports_cubit.dart';

import '../../../../../../generated/l10n.dart';
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
              return Center(child: Text(state.message));
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
      return const Color.fromARGB(255, 201, 184, 24);
    case 'Rejected':
      return Colors.red;
    default:
      return Colors.grey;
  }
}
