import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../core/themes/light_theme.dart';
import '../../../core/utils/constants.dart';
import '../../../core/utils/helper.dart';
import '../data/models/user_model.dart';
import 'Widgets/login_form.dart';
import 'cubits/log_In/log_in_cubit.dart';
import 'widgets/gradient_bg.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocConsumer<LogInCubit, LogInState>(
        listener: (context, state) {
          if (state is LogInError) {
            Helper.showSnackBar(context: context, message: state.message);
          } else if (state is LogInSuccess) {
            _handleSuccessfulLogin(context, state.userModel);
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
                  top: size.height * 0.05,
                  child: Image.asset(
                    Constants.logo,
                    width: size.width * 0.6,
                    filterQuality: FilterQuality.high,
                    semanticLabel: 'App Logo',
                  ),
                ),
                Positioned(bottom: 0, child: LoginFormCard(size: size)),
              ],
            ),
          );
        },
      ),
    );
  }

  void _handleSuccessfulLogin(BuildContext context, UserModel user) {
    final routeName = switch (user.role) {
      'Admin' => 'adminHome',
      'TruckDriver' => 'driverHome',
      _ => 'home',
    };
    GoRouter.of(context).goNamed(routeName);
  }
}
