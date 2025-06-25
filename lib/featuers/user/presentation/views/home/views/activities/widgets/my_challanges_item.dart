import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:green_city/featuers/user/data/models/activities_model.dart';
import 'package:green_city/featuers/user/presentation/cubits/activities/activities_cubit.dart';
import 'package:green_city/generated/l10n.dart';
import '../../../../../../../../core/utils/text_style.dart';

class MyChallangesItem extends StatelessWidget {
  const MyChallangesItem({super.key, required this.activitiesModel});
  final ActivitiesModel activitiesModel;

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
                  child: Text(
                    S.of(context).details,
                    style: MyStyle.title14(context),
                  ),
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
                      activitiesModel.actName ?? '',
                      style: MyStyle.title16(
                        context,
                      ).copyWith(fontWeight: FontWeight.w600),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      activitiesModel.actDescription ?? '',
                      style: MyStyle.title14(context),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    Chip(
                      label: Text(
                        activitiesModel.actIntervalDate ?? '',
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
                  context.read<ActivitiesCubit>().unSubscribe(
                    activityId: activitiesModel.id!,
                  );
                  context.read<ActivitiesCubit>().getMyActivities();
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
                      Text(
                        S.of(context).activity_overview,
                        style: MyStyle.title20(context),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Details
                  _buildDetailRow(
                    context,
                    '${S.of(context).location}:',
                    activitiesModel.actName,
                  ),
                  _buildDetailRow(
                    context,
                    '${S.of(context).type}:',
                    activitiesModel.actDescription,
                  ),
                  _buildDetailRow(
                    context,
                    '${S.of(context).description}:',
                    activitiesModel.actIntervalDate,
                  ),
                  _buildDetailRow(
                    context,
                    '${S.of(context).reported_by}:',
                    activitiesModel.actstate,
                  ),
                  _buildDetailRow(
                    context,
                    '${S.of(context).region}:',
                    activitiesModel.numOfSubscribers.toString(),
                  ),
                  _buildDetailRow(
                    context,
                    '${S.of(context).date}:',
                    activitiesModel.numOfRequiredSubscribers.toString(),
                  ),

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
