import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../core/functions/helper.dart';
import '../../../core/services/get_it_service.dart';
import '../domain/repo/auth_repo.dart';
import 'Widgets/gradient_bg.dart';
import 'Widgets/signup_bottom.dart';
import 'cubits/SignUp/sign_up_cubit.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpCubit(getIt<AuthRepo>()),
      child: Scaffold(
        body: BlocConsumer<SignUpCubit, SignUpState>(
          listener: (context, state) {
            if (state is SignUpError) {
              Helper.showSnackBar(context: context, message: state.message);
            } else if (state is SignUpSuccess) {
              GoRouter.of(context).pushReplacement('/home');
            }
          },
          builder: (context, state) {
            return ModalProgressHUD(
              inAsyncCall: state is SignUpLoading ? true : false,
              child: const Stack(
                children: [
                  GradientBG(),
                  Positioned(bottom: 0, child: SignUpBottom()),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
