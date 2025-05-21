import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/endpoints.dart';
import '../../../../../core/utils/helper.dart';
import '../../../data/models/polls_model.dart';
import '../../../data/repo/user_repo.dart';

part 'polls_state.dart';

class PollsCubit extends Cubit<PollsState> {
  PollsCubit(this._userRepo) : super(PollsInitial());
  final UserRepo _userRepo;

  void getPolls() async {
    emit(PollsLoading());
    final result = await _userRepo.fetchPolls(endPoint: Endpoints.polls);
    result.fold(
      (error) => emit(PollsError(error.errMsg)),
      (data) => emit(PollsLoaded(data)),
    );
  }

  Future<void> votePoll(BuildContext context, {required int pollId}) async {
    // Only emit loading if we have existing data to preserve
    if (state is PollsLoaded) {
      final currentPolls = (state as PollsLoaded).pollsList;
      emit(PollsLoaded(currentPolls)); // Maintain current data while loading
    } else {
      emit(PollsLoading());
    }

    final result = await _userRepo.joinPoll(
      endPoint: Endpoints.polls,
      id: pollId,
    );

    result.fold((error) => emit(PollsVoteError(error.errMsg)), (isVoted) {
      if (isVoted && state is PollsLoaded) {
        final currentPolls = (state as PollsLoaded).pollsList;
        emit(PollsVoted('تم التصويت بنجاح', currentPolls));
        // Open link only after state update is complete
        Future.delayed(Duration.zero, () {
          final poll = currentPolls.firstWhere((p) => p.id == pollId);
          if (poll.pollLink != null) {
            // ignore: use_build_context_synchronously
            Helper.openUrl(context, poll.pollLink!);
          }
        });
        getPolls();
      } else {
        emit(const PollsVoteError('Failed to register vote'));
      }
    });
  }
}
