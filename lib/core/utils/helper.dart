import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:green_city/core/widgets/text_felid.dart';
import 'package:green_city/generated/l10n.dart';
import 'package:image_picker/image_picker.dart';

import '../../featuers/auth/data/models/user_model.dart';
import 'constants.dart';
import '../services/prefs_service.dart';
import '../widgets/modern_button.dart';
import 'text_style.dart';

abstract class Helper {
  static void showAlert({
    required BuildContext context,
    required VoidCallback onTap,
    required String title,
    required TextEditingController controller,
  }) async {
    await showDialog(
      context: context,
      builder:
          (ctx) => Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            backgroundColor: Theme.of(context).colorScheme.surface,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                spacing: 10,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${S.of(context).update} $title',
                    style: MyStyle.title20(context),
                    textAlign: TextAlign.center,
                  ),
                  MyTextField(controller: controller, label: title),
                  const SizedBox(height: 5),
                  ModernButton(
                    onTap: onTap,
                    title: S.of(context).update,
                    icon: Icons.check_circle_rounded,
                  ),
                ],
              ),
            ),
          ),
    );
  }

  static showSnackBar({
    required BuildContext context,
    required String message,
  }) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  static Future<File?> pickImage({required bool isCamera}) async {
    try {
      final image = await ImagePicker().pickImage(
        source: isCamera ? ImageSource.camera : ImageSource.gallery,
      );
      return image != null ? File(image.path) : null;
    } catch (e) {
      return null;
    }
  }

  /// Pushes a WebView route.  If the incoming [url] is missing a scheme
  /// we automatically prefix ‘https://’.
  static Future<void> openUrl(
    BuildContext context,
    String url,
    String title,
  ) async {
    try {
      Uri uri = Uri.parse(url.trim());

      // Add https:// if no scheme
      if (uri.scheme.isEmpty) {
        uri = uri.replace(scheme: 'https');
      }
      if (!uri.isAbsolute) {
        throw const FormatException('Invalid URL format');
      }

      // Wait for the WebView page to return (handy if you need to refresh later)
      await GoRouter.of(
        context,
      ).pushNamed('webView', extra: {'title': title, 'url': uri.toString()});
    } catch (e) {
      // ignore: use_build_context_synchronously
      Helper.showSnackBar(context: context, message: e.toString());
    }
  }

  static UserModel getUser() {
    final user = PrefsService.getString(Constants.kUserData);
    return UserModel.fromJson(jsonDecode(user!));
  }

  static String openPollLink({required String id}) =>
      'https://docs.google.com/forms/d/e/$id/viewform';
}
