import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:green_city/featuers/user/home/data/models/user_reports_model.dart';
import 'package:green_city/generated/l10n.dart';
import '../../../../../../../core/utils/text_style.dart';
import '../../../../../cubits/Driver Tasks/driver_tasks_cubit.dart';

class TodayTaskItem extends StatelessWidget {
  const TodayTaskItem({super.key, required this.userReportsModel});
  final UserReportsModel userReportsModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Padding(
        padding: const EdgeInsets.only(right: 12, top: 12, bottom: 12),
        child: IntrinsicHeight(
          child: Row(
            children: [
              // Details button
              Transform.rotate(
                angle: 3.14 / 2 * 3,
                child: TextButton(
                  onPressed: () => _showDialog(context: context),
                  child: Text('Details', style: MyStyle.title14(context)),
                ),
              ),
              VerticalDivider(color: Colors.grey[400], thickness: 2),
              const SizedBox(width: 12),
              // Main content
              Expanded(
                child: Column(
                  spacing: 4,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userReportsModel.region ?? 'No location',
                      style: MyStyle.title16(
                        context,
                      ).copyWith(fontWeight: FontWeight.w600),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      userReportsModel.todayDate ?? '',
                      style: MyStyle.title14(context),
                    ),
                    Chip(
                      label: Text(
                        userReportsModel.announcementType!,
                        style: const TextStyle(fontSize: 12),
                      ),
                      backgroundColor: Theme.of(
                        context,
                      ).colorScheme.primary.withValues(alpha: 0.1),
                      visualDensity: VisualDensity.compact,
                    ),
                  ],
                ),
              ),

              // Submit button
              ElevatedButton(
                onPressed: () {
                  context.read<DriverTasksCubit>().acceptTask(
                    id: userReportsModel.id!,
                  );
                },
                child: Text(
                  S.of(context).accept,
                  style: MyStyle.title14(
                    context,
                  ).copyWith(color: Colors.white, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDialog({required BuildContext context}) {
    showDialog(
      context: context,
      builder:
          (ctx) => Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(
                color: Theme.of(context).colorScheme.onSurface,
                width: 2,
              ),
            ),
            backgroundColor: Theme.of(context).cardColor,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    children: [
                      Icon(
                        Icons.info,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(width: 8),
                      Text('Task Details', style: MyStyle.title20(context)),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Details
                  _buildDetailRow(
                    context,
                    'Location:',
                    userReportsModel.siteLocation,
                  ),
                  _buildDetailRow(
                    context,
                    'Type:',
                    userReportsModel.announcementType,
                  ),
                  _buildDetailRow(
                    context,
                    'Description:',
                    userReportsModel.announcementDescription,
                  ),
                  _buildDetailRow(
                    context,
                    'Reported by:',
                    userReportsModel.userName,
                  ),
                  _buildDetailRow(context, 'Region:', userReportsModel.region),
                  _buildDetailRow(context, 'Date:', userReportsModel.todayDate),

                  const SizedBox(height: 24),

                  // Close button
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Theme.of(context).colorScheme.primary,
                      ),
                      onPressed: () => Navigator.pop(ctx),
                      child: Text(S.of(context).cancel.toUpperCase()),
                    ),
                  ),
                ],
              ),
            ),
          ),
    );
  }

  Widget _buildDetailRow(BuildContext context, String label, String? value) {
    if (value == null || value.isEmpty) return const SizedBox();

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(label, style: MyStyle.title16(context)),
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(value, style: MyStyle.title16(context))),
        ],
      ),
    );
  }
}
