import 'package:flutter/material.dart';

import '../../generated/l10n.dart';
import '../utils/text_style.dart';

class ErrorsWidget extends StatelessWidget {
  const ErrorsWidget({
    super.key,
    required this.message,
    required this.onPressed,
  });

  final String message;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 48,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              message,
              style: MyStyle.title20(context).copyWith(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: onPressed,
              child: Text(S.of(context).retry),
            ),
          ],
        ),
      ),
    );
  }
}
