import 'package:flutter/material.dart';

import '../../../../core/utils/text_style.dart';

class MyListTile extends StatelessWidget {
  const MyListTile({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        onTap();
        Navigator.of(context).pop();
      },
      title: Text(
        title,
        style: MyStyle.title16(context),
      ),
      leading: Icon(icon),
    );
  }
}
