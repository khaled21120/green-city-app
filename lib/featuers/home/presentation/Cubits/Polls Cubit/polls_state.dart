part of 'polls_cubit.dart';

sealed class PollsState extends Equatable {
  const PollsState();

  @override
  List<Object> get props => [];
}

final class PollsInitial extends PollsState {}

final class PollsLoading extends PollsState {}

final class PollsLoaded extends PollsState {
  final List<PollsModel> pollsList;
  const PollsLoaded(this.pollsList);
}

final class PollsError extends PollsState {
  final String message;
  const PollsError(this.message);
}
