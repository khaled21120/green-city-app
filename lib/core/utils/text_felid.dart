import 'package:flutter/material.dart';
import 'package:green_city/core/utils/text_style.dart';
import 'package:green_city/generated/l10n.dart';

class MyTextFelid extends StatelessWidget {
  const MyTextFelid({
    super.key,
    required this.label,
    required this.controller,
    this.isPassword,
    this.icon,
    this.maxLines,
    this.keyboardType,
  });
  final String label;
  final TextEditingController controller;
  final bool? isPassword;
  final Widget? icon;
  final int? maxLines;
  final TextInputType? keyboardType;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator:
          (value) => (value == null || value.isEmpty) ? '${S.of(context).enter} $label' : null,
      keyboardType: keyboardType ?? TextInputType.emailAddress,
      controller: controller,
      obscureText: isPassword ?? false,
      maxLines: maxLines ?? 1,
      decoration: InputDecoration(
        suffixIcon: icon ?? const SizedBox.shrink(),
        labelStyle: MyStyle.title16(context),
        label: Text(label),
        border: const UnderlineInputBorder(),
      ),
    );
  }
}
