import 'package:flutter/material.dart';

import 'text_style.dart';

class ModernButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const ModernButton({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        foregroundColor: Theme.of(context).colorScheme.surface,
        minimumSize: Size(width * 0.1, 30),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        textStyle: MyStyle.title14(context),
      ),
      icon: Icon(icon, size: 20, color: Theme.of(context).colorScheme.surface),
      onPressed: onTap,
      label: Text(title),
    );
  }
}
