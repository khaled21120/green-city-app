part of 'polls_cubit.dart';

abstract class PollsState extends Equatable {
  const PollsState();

  @override
  List<Object> get props => [];
}

class PollsInitial extends PollsState {}

class PollsLoading extends PollsState {}

class PollsLoaded extends PollsState {
  final List<PollsModel> pollsList;

  const PollsLoaded(this.pollsList);

  @override
  List<Object> get props => [pollsList];
}

class PollsVoted extends PollsLoaded {
  final String message;

  const PollsVoted(this.message, List<PollsModel> pollsList) : super(pollsList);

  @override
  List<Object> get props => [message, ...super.props];
}

class PollsError extends PollsState {
  final String message;

  const PollsError(this.message);

  @override
  List<Object> get props => [message];
}

class PollsVoteError extends PollsState {
  final String message;

  const PollsVoteError(this.message);

  @override
  List<Object> get props => [message];
}
