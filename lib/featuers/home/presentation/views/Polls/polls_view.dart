import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:green_city/featuers/home/presentation/Cubits/Polls%20Cubit/polls_cubit.dart';
import 'package:green_city/featuers/home/presentation/views/Polls/widgets/poll_item.dart';

import '../../../../../generated/l10n.dart';
import '../../widgets/shimmer_grid.dart';

class PollsView extends StatelessWidget {
  const PollsView({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).polls)),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PollsCubit, PollsState>(
          builder: (context, state) {
            if (state is PollsLoading) {
              return ShimmerGridItem(aspectratio: width / (height / 1.5));
            } else if (state is PollsError) {
              return Center(child: Text(state.message));
            } else if (state is PollsLoaded) {
              return GridView.builder(
                itemCount: state.pollsList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: width / (height / 1.5),
                ),
                itemBuilder:
                    (context, index) =>
                        PollsItem(pollsModel: state.pollsList[index]),
              );
            }
            return const Center(child: Text('No Data'));
          },
        ),
      ),
    );
  }
}
