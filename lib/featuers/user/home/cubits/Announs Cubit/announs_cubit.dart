import 'dart:io';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:green_city/core/errors/error.dart';
import 'package:intl/intl.dart';

import '../../../../../core/utils/endpoints.dart';
import '../../../../auth/data/models/user_model.dart';
import '../../data/models/announ_model.dart';
import '../../data/repo/user_home_repo.dart';

part 'announs_state.dart';

class AnnounsCubit extends Cubit<AnnounsState> {
  AnnounsCubit(this.homeRepo) : super(AnnounsInitial());
  final UserHomeRepo homeRepo;

  void sendAnnouncements({
    required String announcementType,
    required String binNumber,
    required DateTime selectedDate,
    required String address,
    required String message,
    required UserModel user,
    required File image,
  }) async {
    emit(AnnounsLoading());
    try {
      final file = await MultipartFile.fromFile(
        image.path,
        filename: image.path.split('/').last,
      );
      final result = await homeRepo.sendAnnouncements(
        endPoint: Endpoints.sendAnnouncements,
        data: {
          'UserName': user.name,
          'Email': user.email,
          'AnnouncementType': announcementType,
          'AnnouncementDescription': message,
          'BinNumber': binNumber,
          'SiteLocation': address,
          'TodayDate': DateFormat.yMd('en').format(selectedDate),
          'PhotoFile': file,
        },
      );
      if (!result) {
        emit(const AnnounsError('حدث خطأ ما. الرجاء المحاولة مرة اخرى'));
      } else {
        emit(const AnnounsSend('تم ارسال الاعلان بنجاح'));
      }
    } on ServerFailure catch (e) {
      emit(AnnounsError(e.toString()));
    }
  }

  void fetchAnnouncements() async {
    emit(AnnounsLoading());
    try {
      final result = await homeRepo.fetchAnnouncements(
        endPoint: Endpoints.getAnnouncements,
      );
      result.fold((error) => emit(AnnounsError(error.errMsg)), (announs) {
        emit(FetchAnnounsSuccess(announs));
      });
    } on ServerFailure catch (e) {
      emit(AnnounsError(e.toString()));
    }
  }
}
