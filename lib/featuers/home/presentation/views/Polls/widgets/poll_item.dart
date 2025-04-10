import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:green_city/core/functions/helper.dart';
import 'package:green_city/featuers/home/data/models/polls_model.dart';
import 'package:green_city/generated/l10n.dart';
import '../../../../../../core/utils/text_style.dart';

class PollsItem extends StatelessWidget {
  const PollsItem({super.key, required this.pollsModel});
  final PollsModel pollsModel;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background Image
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: CachedNetworkImageProvider(pollsModel.imgFile!),
              ),
            ),
          ),
        ),

        // Dark overlay for readability
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),

        // Content
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                pollsModel.pollName!,
                style: MyStyle.title18(context).copyWith(color: Colors.white),
                textAlign: TextAlign.center,
              ),
              Text(
                pollsModel.pollDesc!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: MyStyle.title14(context).copyWith(color: Colors.white70),
                textAlign: TextAlign.center,
              ),
              Text(
                pollsModel.pollEndDate!,
                style: MyStyle.title14(context).copyWith(color: Colors.white70),
                textAlign: TextAlign.center,
              ),
              ElevatedButton(
                onPressed:
                    () => Helper.openUrl(context, pollsModel.pollFormLink!),
                child: Text(S.of(context).vote),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
