import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:green_city/core/utils/text_style.dart';

import '../../featuers/auth/data/models/user_model.dart';
import '../../generated/l10n.dart';

class MyDrawerHeader extends StatelessWidget {
  const MyDrawerHeader({
    super.key,
    required this.userData,
    required this.routeName,
  });

  final UserModel userData;
  final String routeName;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        GoRouter.of(context).pushNamed(routeName);
      },
      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal.shade700, Colors.teal.shade400],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: .2),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + 16,
          left: 16,
          right: 16,
          bottom: 24,
        ),
        child: Column(
          children: [
            Row(
              children: [
                _buildUserAvatar(),
                const SizedBox(width: 16),
                _buildUserInfo(context),
                const Spacer(),
                Icon(
                  Icons.chevron_right_rounded,
                  color: Colors.white.withValues(alpha: .7),
                  size: 30,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserAvatar() {
    return Hero(
      tag: 'user-avatar-$routeName',
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white.withValues(alpha: .5),
            width: 3,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: .2),
              blurRadius: 8,
              spreadRadius: 1,
            ),
          ],
        ),
        child: ClipOval(
          child: CachedNetworkImage(
            imageUrl: userData.profileImage ?? '',
            width: 72,
            height: 72,
            fit: BoxFit.cover,
            placeholder: (context, url) => _buildPlaceHolder(),
            errorWidget: (context, url, error) => _buildPlaceHolder(),
          ),
        ),
      ),
    );
  }

  Widget _buildUserInfo(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            userData.name ?? S.of(context).user_name,
            style: MyStyle.title20(context).copyWith(color: Colors.white),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 6),
          Text(
            userData.email ?? S.of(context).email_address,
            style: MyStyle.title14(
              context,
            ).copyWith(color: Colors.white.withValues(alpha: .6)),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceHolder() {
    return Container(
      color: Colors.grey[200],
      child: const Icon(Icons.person, size: 50, color: Colors.grey),
    );
  }
}
