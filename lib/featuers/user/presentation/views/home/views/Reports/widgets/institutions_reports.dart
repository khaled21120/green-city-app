import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:green_city/core/utils/constants.dart';
import 'package:green_city/core/utils/helper.dart';
import 'package:green_city/core/widgets/button.dart';
import 'package:green_city/core/widgets/text_felid.dart';
import 'package:green_city/featuers/user/data/models/user_reports_model.dart';
import 'package:green_city/featuers/user/presentation/cubits/user_report/user_reports_cubit.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../../../../../../core/utils/text_style.dart';
import '../../../../../../../../generated/l10n.dart';

class InstitutionsReports extends StatefulWidget {
  const InstitutionsReports({super.key});

  @override
  State<InstitutionsReports> createState() => _InstitutionsReportsState();
}

class _InstitutionsReportsState extends State<InstitutionsReports> {
  // ───────────────────────────── Form Keys & Controllers ─────────────────────────────
  final _formKey = GlobalKey<FormState>();
  final _contactNumberCtrl = TextEditingController();
  final _institutionNameCtrl = TextEditingController();
  final _institutionAddressCtrl = TextEditingController();
  final _additionalNotesCtrl = TextEditingController();

  // ───────────────────────────── Dropdown Values ─────────────────────────────
  String? _institutionType;
  String? _paymentMethod;
  String? _subscriptionType;
  String? _subscriptionDuration;

  // ───────────────────────────── Date / Time Values ─────────────────────────────
  DateTime _startDate = DateTime.now();
  TimeOfDay _startTime = TimeOfDay.now();

  // ───────────────────────────── Lifecycle ─────────────────────────────
  @override
  void dispose() {
    _contactNumberCtrl.dispose();
    _institutionNameCtrl.dispose();
    _institutionAddressCtrl.dispose();
    _additionalNotesCtrl.dispose();
    super.dispose();
  }

  // ───────────────────────────── UI Helpers ─────────────────────────────
  Future<void> _pickDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _startDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) setState(() => _startDate = picked);
  }

  Future<void> _pickTime(BuildContext context) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _startTime,
    );
    if (picked != null) setState(() => _startTime = picked);
  }

  void _resetForm() {
    _formKey.currentState?.reset();
    _contactNumberCtrl.clear();
    _institutionNameCtrl.clear();
    _institutionAddressCtrl.clear();
    _additionalNotesCtrl.clear();
    setState(() {
      _institutionType = null;
      _paymentMethod = null;
      _subscriptionType = null;
      _subscriptionDuration = null;
      _startDate = DateTime.now();
      _startTime = TimeOfDay.now();
    });
  }

  String _calculatePrice(String? duration) {
    if (duration == null || duration.isEmpty) return '0';
    final months = int.tryParse(duration.split(' ').first) ?? 0;
    return (months * 300).toString();
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    final user = Helper.getUser();
    final price = _calculatePrice(_subscriptionDuration);

    final report = UserReportsModel(
      userName: user.name,
      email: user.email,
      contactNumber: _contactNumberCtrl.text.trim(),
      institutionName: _institutionNameCtrl.text.trim(),
      siteLocation: _institutionAddressCtrl.text.trim(),
      announcementDescription: _additionalNotesCtrl.text.trim(),
      subscriptionType: _subscriptionType,
      subscriptionDuration: _subscriptionDuration,
      institutionType: _institutionType,
      paymentMethod: _paymentMethod,
      startDate: DateFormat.yMd().format(_startDate),
      startTime: _startTime.format(context),
      price: double.tryParse(price),
    );

    context.read<UserReportsCubit>().sendPayedReports(report);
  }

  // ───────────────────────────── Build ─────────────────────────────
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserReportsCubit, ReportsState>(
      listener: (context, state) {
        if (state is ReportsSend) {
          Helper.showSnackBar(context: context, message: state.message);
          _resetForm();
        } else if (state is ReportsError) {
          Helper.showSnackBar(context: context, message: state.message);
        }
      },
      builder: (context, state) {
        final isLoading = state is ReportsLoading;
        return ModalProgressHUD(
          inAsyncCall: isLoading,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                spacing: 16,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // ─────────── Institution Info ───────────
                  MyTextField(
                    label: S.of(context).institutionName,
                    controller: _institutionNameCtrl,
                    keyboardType: TextInputType.text,
                    icon: const Icon(Icons.apartment),
                  ),
                  MyTextField(
                    label: S.of(context).contactNumber,
                    controller: _contactNumberCtrl,
                    keyboardType: TextInputType.phone,
                    icon: const Icon(Icons.phone),
                  ),
                  MyTextField(
                    label: S.of(context).locationAddress,
                    controller: _institutionAddressCtrl,
                    keyboardType: TextInputType.streetAddress,
                    icon: const Icon(Icons.location_on),
                  ),
                  MyTextField(
                    label: S.of(context).additionalNotes,
                    controller: _additionalNotesCtrl,
                    keyboardType: TextInputType.multiline,
                    icon: const Icon(Icons.description),
                  ),

                  // ─────────── Date & Time ───────────
                  _DateTimeCard(
                    dateLabel: S.of(context).select_date,
                    dateValue: DateFormat.yMd().format(_startDate),
                    onDateTap: () => _pickDate(context),
                    timeLabel: S.of(context).selectTime,
                    timeValue: _startTime.format(context),
                    onTimeTap: () => _pickTime(context),
                  ),

                  const Divider(),

                  // ─────────── Dropdowns ───────────
                  Wrap(
                    spacing: 16,
                    runSpacing: 10,
                    children: [
                      _DropdownField(
                        label: S.of(context).selectInstitution,
                        value: _institutionType,
                        items: const [
                          'Hospital',
                          'School',
                          'University',
                          'Company',
                          'Other',
                        ],
                        onChanged:
                            (val) => setState(() => _institutionType = val),
                      ),
                      _DropdownField(
                        label: S.of(context).paymentMethod,
                        value: _paymentMethod,
                        items: const ['Cash', 'Vodafone Cash', 'Credit Card'],
                        onChanged:
                            (val) => setState(() => _paymentMethod = val),
                      ),
                      _DropdownField(
                        label: S.of(context).subscriptionType,
                        value: _subscriptionType,
                        items: Constants.subscriptionType,
                        onChanged:
                            (val) => setState(() => _subscriptionType = val),
                      ),
                      _DropdownField(
                        label: S.of(context).subscriptionDuration,
                        value: _subscriptionDuration,
                        items: Constants.subscriptionDuration,
                        onChanged:
                            (val) =>
                                setState(() => _subscriptionDuration = val),
                      ),
                    ],
                  ),

                  const SizedBox(height: 4),

                  // ─────────── Price ───────────
                  _PriceCard(price: _calculatePrice(_subscriptionDuration)),

                  const SizedBox(height: 4),

                  MyButton(text: S.of(context).subscribe, onTap: _submitForm),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// ───────────────────────────── Reusable Widgets ─────────────────────────────
class _DropdownField extends StatelessWidget {
  const _DropdownField({
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  final String label;
  final String? value;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: DropdownButtonFormField<String>(
        validator:
            (v) => v == null ? '${S.of(context).please_select} $label' : null,
        value: value,
        decoration: InputDecoration(
          labelText: label,
          border: const UnderlineInputBorder(),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 10,
          ),
        ),
        items:
            items
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
        onChanged: onChanged,
      ),
    );
  }
}

class _DateTimeCard extends StatelessWidget {
  const _DateTimeCard({
    required this.dateLabel,
    required this.dateValue,
    required this.onDateTap,
    required this.timeLabel,
    required this.timeValue,
    required this.onTimeTap,
  });

  final String dateLabel;
  final String dateValue;
  final VoidCallback onDateTap;
  final String timeLabel;
  final String timeValue;
  final VoidCallback onTimeTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withValues(alpha: .1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        spacing: 12,
        children: [
          _RowItem(
            label: dateLabel,
            value: dateValue,
            icon: Icons.calendar_month,
            onTap: onDateTap,
          ),
          _RowItem(
            label: timeLabel,
            value: timeValue,
            icon: Icons.access_time,
            onTap: onTimeTap,
          ),
        ],
      ),
    );
  }
}

class _RowItem extends StatelessWidget {
  const _RowItem({
    required this.label,
    required this.value,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final String value;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(label, style: MyStyle.title16(context)),
        const Spacer(),
        Text(value, style: MyStyle.title16(context)),
        const SizedBox(width: 8),
        IconButton.filled(
          style: IconButton.styleFrom(elevation: 8),
          icon: Icon(icon),
          onPressed: onTap,
        ),
      ],
    );
  }
}

class _PriceCard extends StatelessWidget {
  const _PriceCard({required this.price});

  final String price;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withValues(alpha: .1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(S.of(context).price, style: MyStyle.title18(context)),
          Text(
            '$price EGP',
            style: MyStyle.title18(context).copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
