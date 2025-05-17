import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:green_city/featuers/admin/home/cubits/cubit/admin_reports_cubit.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../../core/functions/helper.dart';
import '../../../../core/themes/light_theme.dart';
import '../../../../core/utils/button.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/text_felid.dart';
import '../../../../core/utils/text_style.dart';
import '../../../../generated/l10n.dart';

class WasteDetails extends StatefulWidget {
  const WasteDetails({super.key, required this.title});
  final String title;

  @override
  State<WasteDetails> createState() => _WasteDetailsState();
}

class _WasteDetailsState extends State<WasteDetails> {
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  final quantityController = TextEditingController();
  final descController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  String? warehouse;
  bool isLoading = false;

  // Waste type pricing information
  static const Map<String, double> wastePrices = {
    'Plastic': 100,
    'Chemical': 150,
    'Paper': 200,
    'Wood': 200,
    'Glass': 300,
    'Metal': 400,
    'Organic': 500,
  };

  @override
  void initState() {
    super.initState();
    quantityController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    quantityController.dispose();
    descController.dispose();
    super.dispose();
  }

  String calculatePrice(String quantity, String type) {
    final quantityValue = double.tryParse(quantity) ?? 0;
    final pricePerKg = wastePrices[type] ?? 0;
    return (quantityValue * pricePerKg).toStringAsFixed(2);
  }

  Future<void> submitForm() async {
    if (!_formKey.currentState!.validate()) {
      setState(() => autovalidateMode = AutovalidateMode.always);
      return;
    }
    setState(() => isLoading = true);
    try {
      final user = Helper.getUser();
      context.read<AdminReportsCubit>().sendAdminReport(
        data: {
          'warehouseManger': user.name,
          'warehouseName': warehouse,
          'sendAt': DateFormat.yMd('en').format(selectedDate),
          'material': widget.title,
          'quantity': quantityController.text,
          'price': calculatePrice(quantityController.text, widget.title),
          'description': descController.text,
        },
      );
      Helper.showSnackBar(
        context: context,
        message: '${widget.title} waste submitted successfully!',
      );
      // Clear form after submission
      setState(() {
        warehouse = null;
        quantityController.clear();
        descController.clear();
      });
    } catch (e) {
      Helper.showSnackBar(
        context: context,
        message: 'Error submitting waste details: ${e.toString()}',
      );
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);
    final price = calculatePrice(quantityController.text, widget.title);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(widget.title), centerTitle: true),
      body: BlocListener<AdminReportsCubit, AdminReportsState>(
        listener: (context, state) {
          if (state is AdminReportsFailure) {
            Helper.showSnackBar(context: context, message: state.message);
          } else if (state is AdminReportsSuccess) {
            Helper.showSnackBar(context: context, message: state.message);
          }
        },
        child: ModalProgressHUD(
          inAsyncCall: isLoading,
          opacity: 0.4,
          progressIndicator: const CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(MyColors.primary),
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Form(
              key: _formKey,
              autovalidateMode: autovalidateMode,
              child: Column(
                spacing: 20,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Waste Type Info Card
                  _buildWasteInfoCard(context, widget.title),

                  // Quantity Input
                  MyTextFelid(
                    controller: quantityController,
                    label: strings.estimatedQuantity,
                    icon: const Icon(FontAwesomeIcons.weightHanging),
                    keyboardType: TextInputType.number,
                  ),

                  // Description Input
                  MyTextFelid(
                    controller: descController,
                    label: strings.additional_information,
                    icon: const Icon(Icons.description),
                    maxLines: 3,
                  ),

                  // Warehouse Selection
                  _buildDropdown(
                    label: strings.select_warehouse,
                    value: warehouse,
                    items: Constants.warehouse,
                    onChanged: (val) => setState(() => warehouse = val),
                  ),
                  const SizedBox(height: 4),

                  // Price Calculation
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      // ignore: deprecated_member_use
                      color: theme.colorScheme.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Builder(
                      builder: (context) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              strings.paymentInformation,
                              style: MyStyle.title18(context),
                            ),
                            Text(
                              '$price EGP',
                              style: MyStyle.title18(context).copyWith(
                                fontWeight: FontWeight.bold,
                                color: theme.colorScheme.primary,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Submit Button
                  Center(
                    child: MyButton(text: strings.submit, onTap: submitForm),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWasteInfoCard(BuildContext context, String wasteType) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(
              _getWasteIcon(wasteType),
              size: 40,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    wasteType,
                    style: MyStyle.title18(
                      context,
                    ).copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Price: ${wastePrices[wasteType]?.toStringAsFixed(2) ?? '0.00'} EGP/kg',
                    style: MyStyle.title16(
                      context,
                    ).copyWith(color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
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
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: label,
        border: const UnderlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
      ),
      value: value,
      items:
          items.map((item) {
            return DropdownMenuItem(value: item, child: Text(item));
          }).toList(),
      onChanged: onChanged,
      validator: (value) {
        if (value == null) {
          return '${S.of(context).please_select} $label';
        }
        return null;
      },
    );
  }

  IconData _getWasteIcon(String wasteType) {
    switch (wasteType.toLowerCase()) {
      case 'plastic':
        return FontAwesomeIcons.recycle;
      case 'chemical':
        return FontAwesomeIcons.flask;
      case 'paper':
        return FontAwesomeIcons.newspaper;
      case 'wood':
        return FontAwesomeIcons.tree;
      case 'glass':
        return FontAwesomeIcons.glassWater;
      case 'metal':
        return FontAwesomeIcons.gear;
      case 'organic':
        return FontAwesomeIcons.leaf;
      default:
        return FontAwesomeIcons.trash;
    }
  }
}
