import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:green_city/featuers/user/data/models/polls_model.dart';
import 'package:green_city/generated/l10n.dart';
import '../../../../../../../../core/utils/text_style.dart';
import '../../../../../cubits/polls/polls_cubit.dart';

class PollsItem extends StatelessWidget {
  const PollsItem({super.key, required this.pollsModel});
  final PollsModel pollsModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background Image with error handling
          if (pollsModel.photo != null)
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: CachedNetworkImage(
                  imageUrl: pollsModel.photo!,
                  fit: BoxFit.cover,
                  errorWidget:
                      (context, url, error) => Container(
                        color: Colors.grey[300],
                        child: const Icon(Icons.error),
                      ),
                ),
              ),
            ),

          // Dark overlay with opacity based on brightness
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                // ignore: deprecated_member_use
                color: Colors.black.withOpacity(0.6),
              ),
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  pollsModel.pollName ?? '',
                  style: MyStyle.title18(
                    context,
                  ).copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Text(
                  pollsModel.pollDesc ?? '',
                  style: MyStyle.title14(
                    context,
                  ).copyWith(color: Colors.white70),
                  textAlign: TextAlign.center,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),
                Text(
                  pollsModel.pollEndDate ?? '',
                  style: MyStyle.title14(
                    context,
                  ).copyWith(color: Colors.white70),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    context.read<PollsCubit>().votePoll(
                      pollId: pollsModel.id!,
                      context,
                    );
                  },
                  child: Text(S.of(context).vote),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
