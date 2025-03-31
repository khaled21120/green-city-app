// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:green_city/core/constants.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../../../../../core/functions/helper.dart';
import '../../../../../../core/themes/light_theme.dart';

class ProfilePicture extends StatefulWidget {
  const ProfilePicture({super.key, this.imageUrl});
  final String? imageUrl;

  @override
  State<ProfilePicture> createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture> {
  bool isLoading = false;

  Future<void> showImage(bool isCamera) async {
    try {
      setState(() => isLoading = true); // Show loader before picking image
      final file = await Helper.pickImage(isCamera: isCamera);
      Navigator.pop(context);
      if (file != null) {
      } else {
        Helper.showSnackBar(context: context, message: 'No image selected');
      }
    } catch (e) {
      Helper.showSnackBar(context: context, message: 'Error picking image');
    } finally {
      setState(() => isLoading = false); // Hide loader after process
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: CircleAvatar(
        radius: 70,
        backgroundImage:
            widget.imageUrl != null && widget.imageUrl!.isNotEmpty
                ? NetworkImage(widget.imageUrl!)
                : const AssetImage(Constants.person),
        backgroundColor: MyColors.white,
        child: Align(
          alignment: Alignment.bottomRight,
      
          child: Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: MyColors.gradient2,
            ),
            child: IconButton(
              color: MyColors.white,
              onPressed: () {
                Helper.imagePicAlert(
                  context: context,
                  leftFunc: () => showImage(true),
                  rightFunc: () => showImage(false),
                );
              },
              icon: const Icon(Icons.add_a_photo_rounded, size: 24),
            ),
          ),
        ),
      ),
    );
  }
}
