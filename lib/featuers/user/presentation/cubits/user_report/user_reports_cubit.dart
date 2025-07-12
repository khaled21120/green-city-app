import 'dart:io';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:green_city/core/errors/error.dart';
import 'package:green_city/core/services/prefs_service.dart';
import 'package:intl/intl.dart';

import '../../../../../core/utils/endpoints.dart';
import '../../../../auth/data/models/user_model.dart';
import '../../../data/models/region_model.dart';
import '../../../data/models/user_reports_model.dart';
import '../../../data/repo/user_repo.dart';

part 'user_reports_state.dart';

class UserReportsCubit extends Cubit<ReportsState> {
  UserReportsCubit(this.homeRepo) : super(ReportsInitial());
  final UserRepo homeRepo;

  List<RegionModel> regions = [];

  void sendReports({
    required String announcementType,
    required String binNumber,
    required DateTime selectedDate,
    required String address,
    required String region,
    required String message,
    required UserModel user,
    required File image,
  }) async {
    emit(ReportsLoading());
    try {
      final file = await MultipartFile.fromFile(
        image.path,
        filename: image.path.split('/').last,
      );
      final result = await homeRepo.sendUserReports(
        endPoint: Endpoints.sendUserReports,
        data: {
          'UserName': user.name,
          'Email': user.email,
          'AnnouncementType': announcementType,
          'AnnouncementDescription': message,
          'BinNumber': binNumber,
          'SiteLocation': address,
          'regionName': region,
          'TodayDate': DateFormat.yMd('en').format(selectedDate),
          'PhotoFile': file,
        },
      );
      result.fold((error) => emit(ReportsError(error.errMsg)), (announs) {
        emit(const ReportsSend('تم ارسال الاعلان بنجاح'));
      });
    } on ServerFailure catch (e) {
      emit(ReportsError(e.toString()));
    }
  }

  void sendPayedReports(UserReportsModel userReportsModel) async {
    emit(ReportsLoading());
    try {
      final result = await homeRepo.sendUserReports(
        endPoint: Endpoints.sendPayedReports,
        data: userReportsModel.toJson(),
      );
      await PrefsService.isSub(true);
      result.fold((error) => emit(ReportsError(error.errMsg)), (announs) {
        emit(const ReportsSend('تم ارسال الاعلان بنجاح'));
      });
    } on ServerFailure catch (e) {
      emit(ReportsError(e.toString()));
    }
  }

  void fetchReports() async {
    emit(ReportsLoading());
    try {
      final result = await homeRepo.fetchUserReports(
        endPoint: Endpoints.getUserReports,
      );
      result.fold((error) => emit(ReportsError(error.errMsg)), (announs) {
        emit(FetchReportsSuccess(announs));
      });
    } on ServerFailure catch (e) {
      emit(ReportsError(e.toString()));
    }
  }

  void fetchSubscribStatus() async {
    emit(ReportsLoading());
    try {
      final res = await homeRepo.fetchSubscribStatus(
        endPoint: Endpoints.getSubscribStatus,
      );
      res.fold((error) => emit(ReportsError(error.errMsg)), (sub) {
        emit(FetchSubSuccess(sub));
      });
    } on ServerFailure catch (e) {
      emit(ReportsError(e.toString()));
    }
  }

  Future<void> cancelSubscription() async {
    emit(ReportsLoading());
    try {
      final res = await homeRepo.cancelSubscription(
        endPoint: Endpoints.cancelSubscription,
      );
      await PrefsService.isSub(false);
      res.fold(
        (error) => emit(ReportsError(error.errMsg)),
        (_) => emit(const CancelSubscription('Cancel Subscription')),
      );
    } on ServerFailure catch (e) {
      emit(ReportsError(e.toString()));
    }
  }

  void fetchRegions() async {
    emit(ReportsLoading());
    try {
      final result = await homeRepo.fetchRegions(endPoint: Endpoints.region);
      result.fold((error) => emit(ReportsError(error.errMsg)), (regions) {
        this.regions = regions;
        emit(FetchRegionsSuccess(regions));
      });
    } on ServerFailure catch (e) {
      emit(FetchRegionsError(e.toString()));
    }
  }
}
