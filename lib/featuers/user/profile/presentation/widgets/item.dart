import 'package:flutter/material.dart';

import '../../../../../core/utils/text_style.dart';

class ProfileItem extends StatelessWidget {
  const ProfileItem({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.value,
    this.showTrailingIcon = true,
  });

  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final String? value;
  final bool showTrailingIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Material(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).dividerColor.withValues(alpha: .1),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).colorScheme.primary.withValues(alpha: .1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    size: 20,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: MyStyle.title16(context)),
                      if (value != null && value!.isNotEmpty) ...[
                        const SizedBox(height: 4),
                        Text(
                          value!,
                          style: MyStyle.title16(context).copyWith(),
                        ),
                      ],
                    ],
                  ),
                ),
                if (showTrailingIcon)
                  Icon(
                    Icons.chevron_right_rounded,
                    color: Theme.of(context).hintColor,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
