part of 'announs_cubit.dart';

sealed class AnnounsState extends Equatable {
  const AnnounsState();

  @override
  List<Object> get props => [];
}

final class AnnounsInitial extends AnnounsState {}

final class AnnounsLoading extends AnnounsState {}

final class AnnounsSend extends AnnounsState {
  final String message;
  const AnnounsSend(this.message);
}

final class FetchAnnounsSuccess extends AnnounsState {
  final List<AnnounsModel> announsList;
  const FetchAnnounsSuccess(this.announsList);
}

final class AnnounsError extends AnnounsState {
  final String message;
  const AnnounsError(this.message);
}
