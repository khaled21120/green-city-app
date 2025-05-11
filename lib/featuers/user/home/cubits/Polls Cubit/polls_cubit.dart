import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/endpoints.dart';
import '../../data/models/polls_model.dart';
import '../../data/repo/user_home_repo.dart';

part 'polls_state.dart';

class PollsCubit extends Cubit<PollsState> {
  PollsCubit(this.homeRepo) : super(PollsInitial());
  final UserHomeRepo homeRepo;

  void getPolls() async {
    emit(PollsLoading());
    final userPolls = await homeRepo.fetchPolls(endPoint: Endpoints.polls);
    userPolls.fold(
      (error) => emit(PollsError(error.errMsg)),
      (data) => emit(PollsLoaded(data)),
    );
  }
}
