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

    final allPollsResult = await _userRepo.fetchPolls(
      endPoint: Endpoints.polls,
    );
    final myPollsResult = await _userRepo.fetchPolls(
      endPoint: Endpoints.myPolls,
    );

    if (allPollsResult.isLeft()) {
      emit(PollsError(allPollsResult.fold((l) => l.errMsg, (_) => '')));
      return;
    }

    if (myPollsResult.isLeft()) {
      emit(PollsError(myPollsResult.fold((l) => l.errMsg, (_) => '')));
      return;
    }

    final allPolls = allPollsResult.getOrElse(() => []);
    final myPolls = myPollsResult.getOrElse(() => []);

    // Filter logic: exclude any poll that exists in myPolls
    final myPollIds = myPolls.map((poll) => poll.id).toSet();

    final notMyPolls =
        allPolls.where((poll) => !myPollIds.contains(poll.id)).toList();

    emit(PollsLoaded(notMyPolls));
  }

  Future<void> votePoll(BuildContext context, {required int pollId}) async {
    // Preserve UI state
    final hasData = state is PollsLoaded;
    if (!hasData) emit(PollsLoading());

    final result = await _userRepo.joinPoll(
      endPoint: Endpoints.polls,
      id: pollId,
    );

    result.fold((error) => emit(PollsVoteError(error.errMsg)), (isVoted) async {
      // Success → update local list (optimistic) before refetch
      final current = (state as PollsLoaded).pollsList;
      emit(PollsVoted('تم التصويت بنجاح', current));

      // 🔗 Open poll link (if present)
      final poll = current.firstWhere((p) => p.id == pollId);
      final rawLink = poll.pollLink;
      if (rawLink != null && rawLink.isNotEmpty) {
        final pollLink = Helper.openPollLink(id: rawLink.split('/')[6]);
        await Helper.openUrl(context, pollLink, poll.pollName ?? 'Poll');
      }

      // Finally refetch to keep everything in sync
      getPolls();
    });
  }
}
