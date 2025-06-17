// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:green_city/core/widgets/text_felid.dart';
import 'package:green_city/featuers/user/data/models/user_reports_model.dart';
import 'package:green_city/generated/l10n.dart';
import 'package:intl/intl.dart';
import '../../../../../../../../core/utils/helper.dart';
import '../../../../../../../../core/utils/text_style.dart';
import '../../../../../../../auth/data/models/user_model.dart';
import '../../../../../cubits/Driver Reports/driver_reports_cubit.dart';

class PendingTaskItem extends StatefulWidget {
  const PendingTaskItem({
    super.key,
    required this.userReportsModel,
    required this.userModel,
    required this.id,
  });

  final UserModel userModel;
  final int id;
  final UserReportsModel userReportsModel;

  @override
  State<PendingTaskItem> createState() => _PendingTaskItemState();
}

class _PendingTaskItemState extends State<PendingTaskItem> {
  final _noteController = TextEditingController();
  final ValueNotifier<File?> _imageNotifier = ValueNotifier(null);
  final ValueNotifier<bool> _isLoadingNotifier = ValueNotifier(false);

  @override
  void dispose() {
    _noteController.dispose();
    _imageNotifier.dispose();
    _isLoadingNotifier.dispose();
    super.dispose();
  }

  Future<void> pickImage(bool isCamera) async {
    try {
      _isLoadingNotifier.value = true;
      final file = await Helper.pickImage(isCamera: isCamera);
      if (!mounted) return;

      if (file != null) {
        _imageNotifier.value = file;
      } else {
        Helper.showSnackBar(context: context, message: S.of(context).no_image);
      }
    } catch (e) {
      Helper.showSnackBar(context: context, message: S.of(context).no_image);
    } finally {
      _isLoadingNotifier.value = false;
    }
  }

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
              _buildDetailsButton(),
              VerticalDivider(
                color: Theme.of(context).dividerColor,
                thickness: 1.5,
                width: 20,
              ),
              const SizedBox(width: 8),
              // Main content
              Expanded(child: _buildTaskInfo()),
              // Submit button
              _buildSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailsButton() {
    return Transform.rotate(
      angle: 3.14 / 2 * 3,
      child: TextButton(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 8),
        ),
        onPressed: () => _showDetailsDialog(),
        child: Text(S.of(context).details, style: MyStyle.title14(context)),
      ),
    );
  }

  Widget _buildTaskInfo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.userReportsModel.region ?? '',
          style: MyStyle.title16(context).copyWith(fontWeight: FontWeight.w600),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4),
        Text(
          widget.userReportsModel.todayDate ?? '',
          style: MyStyle.title14(
            context,
          ).copyWith(color: Theme.of(context).textTheme.bodySmall?.color),
        ),
        const SizedBox(height: 4),
        Chip(
          labelPadding: const EdgeInsets.symmetric(horizontal: 8),
          label: Text(
            widget.userReportsModel.announcementType ?? '',
            style: MyStyle.title12(context),
          ),
          backgroundColor: Theme.of(
            context,
          ).colorScheme.primary.withOpacity(0.1),
          visualDensity: VisualDensity.compact,
        ),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: ElevatedButton(
        onPressed: () => _showCompleteDialog(),
        child: Text(
          S.of(context).submit,
          style: MyStyle.title14(
            context,
          ).copyWith(color: Colors.white, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  void _showDetailsDialog() {
    showDialog(
      context: context,
      builder: (ctx) => _buildDetailsDialogContent(ctx),
    );
  }

  Widget _buildDetailsDialogContent(BuildContext dialogContext) {
    return Dialog(
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
                Icon(Icons.info, color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  S.of(context).task_details,
                  style: MyStyle.title20(context),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Details
            _buildDetailRow(
              context,
              '${S.of(context).location}:',
              widget.userReportsModel.siteLocation,
            ),
            _buildDetailRow(
              context,
              '${S.of(context).type}:',
              widget.userReportsModel.announcementType,
            ),
            _buildDetailRow(
              context,
              '${S.of(context).desc}:',
              widget.userReportsModel.announcementDescription,
            ),
            _buildDetailRow(
              context,
              '${S.of(context).reported_by}:',
              widget.userReportsModel.userName,
            ),
            _buildDetailRow(
              context,
              '${S.of(context).region}:',
              widget.userReportsModel.region,
            ),
            _buildDetailRow(
              context,
              '${S.of(context).date}:',
              widget.userReportsModel.todayDate,
            ),

            const SizedBox(height: 24),

            // Close button
            _buildDialogCloseButton(dialogContext),
          ],
        ),
      ),
    );
  }

  void _showCompleteDialog() {
    showDialog(
      context: context,
      builder: (ctx) => _buildCompleteDialogContent(ctx),
    );
  }

  Widget _buildCompleteDialogContent(BuildContext dialogContext) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: Theme.of(context).colorScheme.onSurface,
          width: 2,
        ),
      ),
      backgroundColor: Theme.of(context).cardColor,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDialogHeader(S.of(context).task_report),
              const SizedBox(height: 16),
              MyTextField(
                label: S.of(context).desc,
                controller: _noteController,
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              _buildImageUploadSection(),
              const SizedBox(height: 24),
              _buildDialogActionButtons(dialogContext),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDialogHeader(String title) {
    return Row(
      children: [
        Icon(Icons.info_outline, color: Theme.of(context).colorScheme.primary),
        const SizedBox(width: 8),
        Text(
          title,
          style: MyStyle.title20(context).copyWith(fontWeight: FontWeight.bold),
        ),
      ],
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

  Widget _buildImageUploadSection() {
    return ValueListenableBuilder<File?>(
      valueListenable: _imageNotifier,
      builder: (context, image, _) {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.05),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Theme.of(context).dividerColor, width: 1),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    S.of(context).upload_image,
                    style: MyStyle.title16(context),
                  ),
                  const Spacer(),
                  ValueListenableBuilder<bool>(
                    valueListenable: _isLoadingNotifier,
                    builder: (context, isLoading, _) {
                      return isLoading
                          ? const CircularProgressIndicator.adaptive()
                          : Row(
                            children: [
                              if (image != null)
                                Flexible(
                                  child: Text(
                                    image.path.split('/').last,
                                    style: MyStyle.title14(context),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                              IconButton(
                                icon: const Icon(FontAwesomeIcons.camera),
                                onPressed: () => pickImage(true),
                                tooltip: S.of(context).take_photo,
                              ),
                            ],
                          );
                    },
                  ),
                ],
              ),
              if (image != null) ...[
                const SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(
                    image,
                    height: 120,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  Widget _buildDialogCloseButton(BuildContext dialogContext) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: Theme.of(context).colorScheme.primary,
        ),
        onPressed: () => Navigator.pop(dialogContext),
        child: Text(S.of(context).cancel.toUpperCase()),
      ),
    );
  }

  Widget _buildDialogActionButtons(BuildContext dialogContext) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () => Navigator.pop(dialogContext),
          child: Text(S.of(context).cancel),
        ),
        const SizedBox(width: 16),
        ElevatedButton(
          onPressed: () {
            if (_imageNotifier.value == null || _noteController.text.isEmpty) {
              Helper.showSnackBar(
                context: context,
                message: 'Please fill all the fields',
              );
              return;
            }
            // Handle task completion logic here
            final image = _imageNotifier.value;
            Navigator.pop(dialogContext);
            context.read<DriverReportsCubit>().completeTask(
              name: widget.userModel.name ?? 'User',
              desc: _noteController.text,
              sentAt: DateFormat.yMd().format(DateTime.now()),
              announcementsID: widget.id,
              photoFile: image!,
            );
          },
          child: Text(S.of(context).submit),
        ),
      ],
    );
  }
}
