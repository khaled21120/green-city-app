// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:green_city/core/utils/text_style.dart';
import 'package:green_city/generated/l10n.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({
    super.key,
    required this.label,
    required this.controller,
    this.isPassword = false,
    this.icon,
    this.maxLines = 1,
    this.keyboardType,
    this.borderRadius = 8.0,
    this.enabled = true,
  });

  final String label;
  final TextEditingController controller;
  final bool isPassword;
  final Widget? icon;
  final int maxLines;
  final TextInputType? keyboardType;
  final double borderRadius;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      maxLines: maxLines,
      keyboardType: keyboardType,
      enabled: enabled,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '${S.of(context).enter} $label';
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: label,
        suffixIcon: icon,
        filled: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        fillColor: Theme.of(
          context,
        ).colorScheme.surfaceContainerHighest.withOpacity(0.4),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).colorScheme.outline),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).colorScheme.outline),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).colorScheme.error),
        ),
        focusedErrorBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.error,
            width: 2,
          ),
        ),
        labelStyle: MyStyle.title16(context).copyWith(
          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
        ),
        errorStyle: MyStyle.title14(
          context,
        ).copyWith(color: Theme.of(context).colorScheme.error),
      ),
    );
  }
}
