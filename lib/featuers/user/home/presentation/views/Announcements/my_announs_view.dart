import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:green_city/core/utils/text_style.dart';
import 'package:green_city/featuers/user/home/cubits/Announs%20Cubit/announs_cubit.dart';

import '../../../../../../generated/l10n.dart';
import '../../widgets/shimmer_grid.dart';

class MyAnnounsView extends StatelessWidget {
  const MyAnnounsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).my_announcements)),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: BlocBuilder<AnnounsCubit, AnnounsState>(
          builder: (context, state) {
            if (state is AnnounsLoading) {
              return const ShimmerGridItem(aspectratio: 1);
            } else if (state is AnnounsError) {
              return Center(child: Text(state.message));
            } else if (state is FetchAnnounsSuccess) {
              if (state.announsList.isEmpty) {
                return Center(child: Text(S.of(context).no_announcements));
              }
              return GridView.builder(
                itemCount: state.announsList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemBuilder: (context, index) {
                  final item = state.announsList[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 3,
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
                            style: MyStyle.title14(
                              context,
                            ).copyWith(color: Colors.grey[700]),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            item.announcementDescription ?? 'No description',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: MyStyle.title14(
                              context,
                            ).copyWith(color: Colors.grey[400]),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 4,
                              horizontal: 10,
                            ),
                            decoration: BoxDecoration(
                              color: getColor(item.status ?? ''),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              item.status ?? 'Unknown',
                              style: MyStyle.title14(context).copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              const Icon(
                                Icons.date_range,
                                size: 16,
                                color: Colors.grey,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                item.todayDate ?? '',
                                style: MyStyle.title14(context),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on,
                                size: 16,
                                color: Colors.grey,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                item.siteLocation ?? '',
                                style: MyStyle.title14(context),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}

Color getColor(String status) {
  switch (status) {
    case 'Approved':
      return Colors.green;
    case 'Pending':
      return const Color.fromARGB(255, 201, 184, 24);
    case 'Rejected':
      return Colors.red;
    default:
      return Colors.grey;
  }
}
