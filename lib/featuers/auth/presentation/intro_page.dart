import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:green_city/generated/l10n.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../../../core/constants.dart';
import '../../../core/themes/light_theme.dart';
import '../../../core/functions/helper.dart';
import '../../../core/services/get_it_service.dart';
import '../../../core/utils/button.dart';
import '../../../core/utils/text_style.dart';
import '../domain/repo/auth_repo.dart';
import 'cubits/LogIn/log_in_cubit.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => LogInCubit(getIt<AuthRepo>()),
      child: Scaffold(
        body: BlocConsumer<LogInCubit, LogInState>(
          listener: (context, state) {
            if (state is LogInError) {
              Helper.showSnackBar(context: context, message: state.message);
            } else if (state is LogInSuccess) {
              GoRouter.of(context).pushReplacement('/home');
            }
          },
          builder: (context, state) {
            return ModalProgressHUD(
              inAsyncCall: state is LogInLoading ? true : false,
              child: Container(
                width: width,
                height: height,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [MyColors.gradient1, MyColors.gradient2],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Image.asset(
                      Constants.logo,
                      height: height * 0.4,
                      width: width * 0.5,
                    ),
                    const SizedBox(height: 70),
                    MyButton(
                      onTap:
                          () => GoRouter.of(context).pushReplacement('/login'),
                      text: S.of(context).sign_in,
                    ),
                    const SizedBox(height: 20),
                    MyButton(
                      text: S.of(context).sign_up,
                      onTap:
                          () => GoRouter.of(context).pushReplacement('/signup'),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        const Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Divider(thickness: 1),
                          ),
                        ),
                        Text(
                          S.of(context).sign_in_with,
                          style: MyStyle.title16(context),
                        ),
                        const Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Divider(thickness: 1),
                          ),
                        ),
                      ],
                    ),
                    // const SizedBox(height: 20),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //   children: [
                    //     ModernButton(
                    //       onTap: () {
                    //         // Google login logic here
                    //         context.read<LogInCubit>().logInWthGoogle();
                    //       },
                    //       icon: FontAwesomeIcons.google,
                    //       title: 'Google',
                    //     ),

                    //     ModernButton(
                    //       onTap: () {
                    //         // Facebook login logic here
                    //         context.read<LogInCubit>().logInWthFaceBook();
                    //       },
                    //       icon: FontAwesomeIcons.facebook,
                    //       title: 'Facebook',
                    //     ),
                    //   ],
                    // ),
                    // const SizedBox(height: 40),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
