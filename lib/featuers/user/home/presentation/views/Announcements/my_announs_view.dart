import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:green_city/featuers/user/home/cubits/Announs%20Cubit/announs_cubit.dart';

import '../../../../../../generated/l10n.dart';
import '../../widgets/shimmer_grid.dart';
import 'widgets/anounn_item.dart';

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
              return const ShimmerGridItem(aspectratio: 0.75);
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
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (context, index) {
                  final item = state.announsList[index];
                  return AnnounsItem(
                    item: item,
                    color: getColor(item.status ?? ''),
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
