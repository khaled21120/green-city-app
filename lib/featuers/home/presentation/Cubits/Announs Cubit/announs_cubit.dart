import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:green_city/core/errors/error.dart';
import 'package:green_city/featuers/home/data/models/announs_model.dart';

import '../../../../../core/utils/endpoints.dart';
import '../../../data/repo/home_repo.dart';

part 'announs_state.dart';

class AnnounsCubit extends Cubit<AnnounsState> {
  AnnounsCubit(this.homeRepo) : super(AnnounsInitial());
  final HomeRepo homeRepo;

  void sendAnnouncements(AnnounsModel announsModel) async {
    emit(AnnounsLoading());
    try {
      homeRepo.sendAnnouncements(
        endPoint: Endpoints.announcements,
        data: announsModel.toJson(),
      );
      emit(const AnnounsSend('تم ارسال الاعلان بنجاح'));
    } on ServerFailure catch (e) {
      emit(AnnounsError(e.toString()));
    }
  }
}
