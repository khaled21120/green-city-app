import 'package:flutter/material.dart';
import 'package:green_city/featuers/user/data/models/user_reports_model.dart';

import '../../../../../../../../core/utils/text_style.dart';

class AnnounsItem extends StatelessWidget {
  const AnnounsItem({super.key, required this.item, required this.color});
  final UserReportsModel item;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.announcementType ?? 'No Type',
              style: MyStyle.title16(
                context,
              ).copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              item.email ?? 'No Email',
              style: MyStyle.title14(context).copyWith(color: Colors.grey[700]),
            ),
            const SizedBox(height: 6),
            Text(
              item.announcementDescription ?? 'No description',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: MyStyle.title14(context).copyWith(color: Colors.grey[400]),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                item.status ?? 'Unknown',
                style: MyStyle.title14(
                  context,
                ).copyWith(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            const Spacer(),
            Row(
              children: [
                const Icon(Icons.date_range, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Text(item.todayDate ?? '', style: MyStyle.title14(context)),
              ],
            ),
            Row(
              children: [
                const Icon(Icons.location_on, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Text(item.siteLocation ?? '', style: MyStyle.title14(context)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
