import 'package:flutter/material.dart';
import 'package:green_city/core/utils/button.dart';
import 'package:green_city/core/utils/text_felid.dart';
import 'package:intl/intl.dart';

import '../../../../../../core/utils/text_style.dart';
import '../../../../../../generated/l10n.dart';

class InstitutionsAnnouns extends StatefulWidget {
  const InstitutionsAnnouns({super.key});

  @override
  State<InstitutionsAnnouns> createState() => _InstitutionsAnnounsState();
}

class _InstitutionsAnnounsState extends State<InstitutionsAnnouns> {
  // Form Controllers
  final _formKey = GlobalKey<FormState>();
  final contactNumberController = TextEditingController();
  final institutionNameController = TextEditingController();
  final locationAddressController = TextEditingController();
  final additionalNotesController = TextEditingController();
  final estimatedQuantityController = TextEditingController();

  // Dropdown Values
  String? requestSource;
  String? wasteType;
  String? paymentMethod;

  // Date/Time Values
  DateTime selectedDate = DateTime.now();
  TimeOfDay? selectedTime;

  // Form State
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  @override
  void dispose() {
    contactNumberController.dispose();
    institutionNameController.dispose();
    locationAddressController.dispose();
    additionalNotesController.dispose();
    estimatedQuantityController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() => selectedDate = pickedDate);
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() => selectedTime = pickedTime);
    }
  }

  void _resetForm() {
    setState(() {
      contactNumberController.clear();
      institutionNameController.clear();
      locationAddressController.clear();
      additionalNotesController.clear();
      estimatedQuantityController.clear();
      requestSource = null;
      wasteType = null;
      paymentMethod = null;
      selectedDate = DateTime.now();
      selectedTime = null;
    });
  }

  String claculatePrice(String quantity, String type) {
    final price = double.tryParse(quantity);
    if (price != null) {
      switch (type) {
        case 'Plastic':
          return (price * 100).toStringAsFixed(2);
        case 'Chemical':
          return (price * 150).toStringAsFixed(2);
        case 'Paper':
          return (price * 200).toStringAsFixed(2);
        case 'Wood':
          return (price * 200).toStringAsFixed(2);
        case 'Glass':
          return (price * 300).toStringAsFixed(2);
        case 'Metal':
          return (price * 400).toStringAsFixed(2);
        case 'Organic':
          return (price * 500).toStringAsFixed(2);
        default:
          return '0';
      }
    } else {
      return '0';
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Form is valid, proceed with submission
      _resetForm();
    } else {
      // Form is invalid, show validation errors
      setState(() => autovalidateMode = AutovalidateMode.always);
    }
  }

  @override
  Widget build(BuildContext context) {
    final price =
        '${S.of(context).paymentInformation}: ${claculatePrice(estimatedQuantityController.text, wasteType ?? '')} EGP';
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          spacing: 16,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Institution Information
            MyTextFelid(
              label: S.of(context).institutionName,
              controller: institutionNameController,
              keyboardType: TextInputType.text,
              icon: const Icon(Icons.apartment),
            ),

            // Contact Information
            MyTextFelid(
              label: S.of(context).contactNumber,
              controller: contactNumberController,
              keyboardType: TextInputType.phone,
              icon: const Icon(Icons.phone),
            ),

            // Location Information
            MyTextFelid(
              label: S.of(context).locationAddress,
              controller: locationAddressController,
              keyboardType: TextInputType.text,
              icon: const Icon(Icons.location_on),
            ),

            // Additional Notes
            MyTextFelid(
              label: S.of(context).additionalNotes,
              controller: additionalNotesController,
              keyboardType: TextInputType.text,
              icon: const Icon(Icons.description),
            ),

            // Waste Quantity
            MyTextFelid(
              label: S.of(context).estimatedQuantity,
              controller: estimatedQuantityController,
              keyboardType: TextInputType.number,
              icon: const Text(
                'KG',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),

            // Date/Time Pickers
            _buildDateTimeRow(
              label: S.of(context).select_date,
              value: DateFormat.yMd().format(selectedDate),
              icon: Icons.calendar_month,
              onTap: () => _selectDate(context),
            ),

            _buildDateTimeRow(
              label: S.of(context).selectTime,
              value:
                  selectedTime?.format(context) ??
                  TimeOfDay.now().format(context),
              icon: Icons.access_time,
              onTap: () => _selectTime(context),
            ),
            const SizedBox(height: 8),

            const Divider(),

            // Dropdowns
            Wrap(
              spacing: 16,
              runSpacing: 10,
              children: [
                _buildDropdown(
                  label: S.of(context).selectInstitution,
                  value: requestSource,
                  items: [
                    'Hospital',
                    'School',
                    'University',
                    'Company',
                    'Other',
                  ],
                  onChanged: (val) => setState(() => requestSource = val),
                ),
                _buildDropdown(
                  label: S.of(context).wasteType,
                  value: wasteType,
                  items: [
                    'Chemical',
                    'Plastic',
                    'Glass',
                    'Paper',
                    'Metal',
                    'Wood',
                    'Other',
                  ],
                  onChanged: (val) => setState(() => wasteType = val),
                ),
                _buildDropdown(
                  label: S.of(context).paymentMethod,
                  value: paymentMethod,
                  items: ['Cash', 'Vodafone Cash', 'Credit Card'],
                  onChanged: (val) => setState(() => paymentMethod = val),
                ),
              ],
            ),

            // Payment Information
            Text(price, style: MyStyle.title18(context)),
            const SizedBox(height: 8),

            // Submit Button
            MyButton(text: S.of(context).submit, onTap: _submitForm),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String label,
    required String? value,
    required List<String> items,
    required void Function(String?) onChanged,
  }) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: DropdownButtonFormField<String>(
        validator: (value) {
          if (value == null) {
            return '${S.of(context).please_select} $label';
          }
          return null;
        },
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
            items.map((item) {
              return DropdownMenuItem(value: item, child: Text(item));
            }).toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildDateTimeRow({
    required String label,
    required String value,
    required IconData icon,
    required VoidCallback onTap,
  }) {
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
