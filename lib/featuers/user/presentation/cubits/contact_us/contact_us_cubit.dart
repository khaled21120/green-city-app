import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:green_city/core/utils/endpoints.dart';
import 'package:green_city/featuers/user/data/models/contact_us_model.dart';
import 'package:green_city/featuers/user/data/repo/user_repo.dart';

part 'contact_us_state.dart';

class ContactUsCubit extends Cubit<ContactUsState> {
  ContactUsCubit(this.userRepo) : super(ContactUsInitial());
  final UserRepo userRepo;

  void sendFeedback(ContactUsModel feedback) async {
    emit(ContactUsLoading());
    final result = await userRepo.sendMessage(
      endPoint: Endpoints.contactUs,
      data: feedback.toJson(),
    );
    result.fold((failure) => emit(ContactUsError(failure.errMsg)), (data) {
      emit(const ContactUsSuccess('تم ارسال الاعلان بنجاح'));
    });
  }
}
