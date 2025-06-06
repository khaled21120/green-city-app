import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../core/utils/helper.dart';
import '../../../core/themes/light_theme.dart';
import '../../../core/utils/constants.dart';
import 'Widgets/gradient_bg.dart';
import 'Widgets/signup_form.dart';
import 'cubits/sign_up/sign_up_cubit.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: BlocConsumer<SignUpCubit, SignUpState>(
        listener: (context, state) {
          if (state is SignUpError) {
            Helper.showSnackBar(context: context, message: state.message);
          } else if (state is SignUpSuccess) {
            GoRouter.of(context).goNamed('home');
          }
        },
        builder: (context, state) {
          return ModalProgressHUD(
            inAsyncCall: state is SignUpLoading,
            opacity: 0.4,
            progressIndicator: const CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(MyColors.primary),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                const GradientBG(),
                Positioned(
                  top: height * 0.01,
                  child: Image.asset(
                    Constants.logo,
                    width: width * 0.5,
                    filterQuality: FilterQuality.high,
                    semanticLabel: 'App Logo',
                  ),
                ),
                const Positioned(bottom: 0, child: SignUpForm()),
              ],
            ),
          );
        },
      ),
    );
  }
}
