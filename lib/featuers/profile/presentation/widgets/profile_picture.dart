// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:green_city/core/utils/constants.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../../../core/functions/helper.dart';
import '../../../../core/themes/light_theme.dart';
import '../../cubit/profile_cubit.dart';

class ProfilePicture extends StatefulWidget {
  const ProfilePicture({super.key, this.imageUrl});
  final String? imageUrl;

  @override
  State<ProfilePicture> createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture> {
  bool isLoading = false;
  File? imageFile;

  Future<void> showImage(bool isCamera) async {
    try {
      setState(() => isLoading = true); // Show loader before picking image
      final file = await Helper.pickImage(isCamera: isCamera);
      Navigator.pop(context);
      if (file != null) {
        context.read<ProfileCubit>().updateData(data: file, isImage: true);
        setState(() => imageFile = file);
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
      opacity: 0.4,
      progressIndicator: const CircularProgressIndicator(
        strokeWidth: 2,
        valueColor: AlwaysStoppedAnimation<Color>(MyColors.primary),
      ),
      child: CircleAvatar(
        radius: 70,
        backgroundImage:
            imageFile != null
                ? FileImage(imageFile!) as ImageProvider
                : widget.imageUrl != null && widget.imageUrl!.isNotEmpty
                ? CachedNetworkImageProvider(widget.imageUrl!)
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
