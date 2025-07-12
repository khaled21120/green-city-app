import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:green_city/featuers/user/presentation/cubits/polls/polls_cubit.dart';
import 'package:green_city/featuers/user/presentation/views/home/views/polls/widgets/poll_item.dart';

import '../../../../../../../core/utils/helper.dart';
import '../../../../../../../core/widgets/error_widget.dart';
import '../../../../../../../core/utils/text_style.dart';
import '../../../../../../../core/widgets/shimmer_grid.dart';
import '../../../../../../../generated/l10n.dart';

class PollsView extends StatelessWidget {
  const PollsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).polls)),
      body: RefreshIndicator(
        onRefresh: () async => context.read<PollsCubit>().getPolls(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocConsumer<PollsCubit, PollsState>(
            listener: (context, state) {
              if (state is PollsVoted) {
                Helper.showSnackBar(context: context, message: state.message);
              } else if (state is PollsVoteError) {
                Helper.showSnackBar(context: context, message: state.message);
              }
            },
            builder: (context, state) {
              return _buildContent(context, state);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, PollsState state) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Calculate responsive grid parameters
    final crossAxisCount = screenWidth > 600 ? 3 : 2;
    final childAspectRatio =
        screenWidth > 600 ? 0.8 : screenWidth / (screenHeight / 1.5);

    if (state is PollsLoading) {
      return ShimmerGridItem(aspectRatio: childAspectRatio);
    }

    if (state is PollsError) {
      return Center(
        child: ErrorsWidget(
          message: state.message,
          onPressed: () => context.read<PollsCubit>().getPolls(),
        ),
      );
    }

    if (state is PollsLoaded) {
      if (state.pollsList.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.poll, size: 64, color: Colors.grey),
              const SizedBox(height: 16),
              Text(
                S.of(context).no_data_available,
                style: MyStyle.title20(context).copyWith(color: Colors.grey),
              ),
              TextButton(
                onPressed: () => context.read<PollsCubit>().getPolls(),
                child: Text(S.of(context).retry),
              ),
            ],
          ),
        );
      }

      return GridView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(8),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: childAspectRatio,
        ),
        itemCount: state.pollsList.length,
        itemBuilder:
            (context, index) => PollsItem(
              key: ValueKey(state.pollsList[index].id),
              pollsModel: state.pollsList[index],
            ),
      );
    }

    // Initial state
    return Center(child: Text(S.of(context).no_data_available));
  }
}
