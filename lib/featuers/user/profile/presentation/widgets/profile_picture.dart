// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:green_city/generated/l10n.dart';

import '../../../../../core/functions/helper.dart';
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

  Future<void> _handleImageSelection(bool isCamera) async {
    try {
      setState(() => isLoading = true);
      final file = await Helper.pickImage(isCamera: isCamera);
      if (!mounted) return;

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
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Main Avatar with Hero Animation
        Hero(
          tag: 'profile-avatar',
          child: Container(
            width: 140,
            height: 140,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 3),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withValues(alpha: .2),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: ClipOval(child: _buildProfileImage()),
          ),
        ),

        // Loading Indicator
        if (isLoading)
          const CircularProgressIndicator(
            strokeWidth: 3,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),

        // Edit Button
        Positioned(right: 0, bottom: 0, child: _buildEditButton(context)),
      ],
    );
  }

  Widget _buildProfileImage() {
    if (imageFile != null) {
      return Image.file(imageFile!, fit: BoxFit.cover);
    } else if (widget.imageUrl != null && widget.imageUrl!.isNotEmpty) {
      return CachedNetworkImage(
        imageUrl: widget.imageUrl!,
        fit: BoxFit.cover,
        placeholder: (context, url) => _buildPlaceholder(),
        errorWidget: (context, url, error) => _buildPlaceholder(),
      );
    }
    return _buildPlaceholder();
  }

  Widget _buildPlaceholder() {
    return Container(
      color: Colors.grey[200],
      child: const Icon(Icons.person, size: 60, color: Colors.grey),
    );
  }

  Widget _buildEditButton(BuildContext context) {
    return InkWell(
      onTap: () => _showImagePickerOptions(context),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 2),
        ),
        child: const Icon(Icons.edit_rounded, size: 20, color: Colors.white),
      ),
    );
  }

  void _showImagePickerOptions(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      builder:
          (context) => SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: const Icon(Icons.camera_alt),
                    title: Text(S.of(context).camera),
                    onTap: () {
                      Navigator.pop(context);
                      _handleImageSelection(true);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: Text(S.of(context).gallery),
                    onTap: () {
                      Navigator.pop(context);
                      _handleImageSelection(false);
                    },
                  ),
                ],
              ),
            ),
          ),
    );
  }
}
