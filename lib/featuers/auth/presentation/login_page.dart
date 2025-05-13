import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../core/functions/helper.dart';
import '../../../core/themes/light_theme.dart';
import '../../../core/utils/constants.dart';
import 'Widgets/gradient_bg.dart';
import '../cubits/LogIn/log_in_cubit.dart';
import 'Widgets/login_bottom.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: BlocConsumer<LogInCubit, LogInState>(
        listener: (context, state) {
          if (state is LogInError) {
            Helper.showSnackBar(context: context, message: state.message);
          } else if (state is LogInSuccess) {
            state.userModel.role == null
                ? GoRouter.of(context).goNamed('home')
                : state.userModel.role == 'Admin'
                ? GoRouter.of(context).goNamed('admin')
                : GoRouter.of(context).goNamed('user');
          }
        },
        builder: (context, state) {
          return ModalProgressHUD(
            inAsyncCall: state is LogInLoading,
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
                  top: height * 0.05,
                  child: Image.asset(
                    Constants.logo,
                    width: width * 0.6,
                    filterQuality: FilterQuality.high,
                    semanticLabel: 'App Logo', // Accessibility
                  ),
                ),
                const Positioned(bottom: 0, child: LogInBottom()),
              ],
            ),
          );
        },
      ),
    );
  }
}
