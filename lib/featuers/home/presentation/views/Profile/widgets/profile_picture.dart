// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:green_city/core/constants.dart';
import '../../../../../../core/functions/helper.dart';
import '../../../../../../core/themes/light_theme.dart';

class ProfilePicture extends StatefulWidget {
  const ProfilePicture({super.key, this.imageUrl});
  final String? imageUrl;

  @override
  State<ProfilePicture> createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture> {
  File? image;
  bool isLoading = false;

  Future<void> showImage(bool isCamera) async {
    try {
      setState(() => isLoading = true); // Show loader before picking image
      final file = await Helper.pickImage(isCamera: isCamera);
      Navigator.pop(context);
      if (file != null) {
        setState(() {
          image = file;
        });
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
    return Stack(
      alignment: Alignment.center,
      children: [
        // Profile Picture
        CircleAvatar(
          radius: 70,
          backgroundImage:
              image != null
                  ? FileImage(image!) as ImageProvider
                  : (widget.imageUrl != null && widget.imageUrl!.isNotEmpty
                      ? NetworkImage(widget.imageUrl!)
                      : const AssetImage(Constants.person) as ImageProvider),
          backgroundColor: MyColors.white,
        ),

        // Camera Icon Button
        Positioned(
          bottom: 0,
          right: 0,
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
              icon: const Icon(Icons.add_a_photo_rounded, size: 30),
            ),
          ),
        ),

        // Loading Indicator
        if (isLoading)
          const Positioned.fill(
            child: Center(child: CircularProgressIndicator()),
          ),
      ],
    );
  }
}
