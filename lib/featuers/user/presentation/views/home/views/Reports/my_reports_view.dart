import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:green_city/featuers/user/presentation/cubits/user_report/user_reports_cubit.dart';

import '../../../../../../../core/utils/helper.dart';
import '../../../../../../../core/utils/text_style.dart';
import '../../../../../../../core/widgets/error_widget.dart';
import '../../../../../../../core/widgets/shimmer_grid.dart';
import '../../../../../../../generated/l10n.dart';
import 'widgets/reports_item.dart';

class MyReportsView extends StatelessWidget {
  const MyReportsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).my_reports)),
      body: RefreshIndicator(
        onRefresh: () async => context.read<UserReportsCubit>().fetchReports(),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: BlocConsumer<UserReportsCubit, ReportsState>(
            listener: (context, state) {
              if (state is ReportsError) {
                Helper.showSnackBar(context: context, message: state.message);
              }
            },
            builder: (context, state) {
              return _buildContent(context, state);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, ReportsState state) {
    final screenSize = MediaQuery.of(context).size;
    final isWideScreen = screenSize.width > 600;

    // Responsive grid configuration
    final crossAxisCount = isWideScreen ? 3 : 2;
    final childAspectRatio =
        isWideScreen ? 0.8 : screenSize.width / (screenSize.height / 1.2);

    if (state is ReportsLoading) {
      return ShimmerGridItem(aspectRatio: childAspectRatio);
    }

    if (state is ReportsError) {
      return Center(
        child: ErrorsWidget(
          message: state.message,
          onPressed: () => context.read<UserReportsCubit>().fetchReports(),
        ),
      );
    }

    if (state is FetchReportsSuccess) {
      if (state.announsList.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.poll, size: 64, color: Colors.grey),
              const SizedBox(height: 16),
              Text(
                S.of(context).no_data_available,
                style: MyStyle.title20(context).copyWith(color: Colors.grey),
              ),
              TextButton(
                onPressed:
                    () => context.read<UserReportsCubit>().fetchReports(),
                child: Text(S.of(context).retry),
              ),
            ],
          ),
        );
      }

      return GridView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.only(bottom: 16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: childAspectRatio,
        ),
        itemCount: state.announsList.length,
        itemBuilder: (context, index) {
          final item = state.announsList[index];
          return AnnounsItem(
            key: ValueKey(item.id), 
            item: item,
            color: _getStatusColor(item.status ?? ''),
          );
        },
      );
    }

    // Initial state
    return Center(child: Text(S.of(context).no_data_available));
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'approved':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'rejected':
        return Colors.red;
      case 'completed':
        return Colors.black;
      case 'assigned':
        return Colors.teal;
      default:
        return Colors.grey;
    }
  }
}
