import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../core/functions/helper.dart';
import 'Widgets/gradient_bg.dart';
import 'cubits/LogIn/log_in_cubit.dart';
import 'Widgets/login_bottom.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<LogInCubit, LogInState>(
        listener: (context, state) {
          if (state is LogInError) {
            Helper.showSnackBar(context: context, message: state.message);
          } else if (state is LogInSuccess) {
            GoRouter.of(context).goNamed('home');
          }
        },
        builder: (context, state) {
          return ModalProgressHUD(
            inAsyncCall: state is LogInLoading ? true : false,
            child: const Stack(
              children: [
                GradientBG(),
                Positioned(bottom: 0, child: LogInBottom()),
              ],
            ),
          );
        },
      ),
    );
  }
}
