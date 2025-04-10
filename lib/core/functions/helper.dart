import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:green_city/core/utils/text_felid.dart';
import 'package:green_city/generated/l10n.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../featuers/auth/data/models/user_model.dart';
import '../utils/constants.dart';
import '../services/prefs_service.dart';
import '../utils/modern_button.dart';
import '../utils/text_style.dart';

abstract class Helper {
  static void imagePicAlert({
    required BuildContext context,
    required VoidCallback leftFunc,
    required VoidCallback rightFunc,
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
                spacing: 6,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    S.of(context).update_profile_picture,
                    style: MyStyle.title20(context),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ModernButton(
                        onTap: leftFunc,
                        title: S.of(context).camera,
                        icon: Icons.camera_alt_rounded,
                      ),
                      ModernButton(
                        onTap: rightFunc,
                        title: S.of(context).gallery,
                        icon: Icons.photo_library_rounded,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
    );
  }

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
                  MyTextFelid(controller: controller, label: title),
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

  static void openUrl(BuildContext context, String url) async {
    final pollLink = Uri.parse(url);
    if (await canLaunchUrl(pollLink)) {
      await launchUrl(pollLink);
    } else {
      // ignore: use_build_context_synchronously
      Helper.showSnackBar(context: context, message: 'Could not launch ');
    }
  }

  static Future<UserModel> getUser() async{
    final user = PrefsService.getString(Constants.kUserData);
    return UserModel.fromJson(jsonDecode(user!));
  }
}
