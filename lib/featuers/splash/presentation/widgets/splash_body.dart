// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:green_city/featuers/auth/cubits/Auth/auth_cubit.dart';

import '../../../../core/utils/constants.dart';
import '../../../../core/services/prefs_service.dart';
import '../../../../core/utils/text_style.dart';

class SplashBody extends StatefulWidget {
  const SplashBody({super.key});

  @override
  State<SplashBody> createState() => _SplashBodyState();
}

class _SplashBodyState extends State<SplashBody>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Offset> slideAnimation;
  void initAnimation() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    slideAnimation = Tween<Offset>(
      begin: const Offset(0, 2),
      end: Offset.zero,
    ).animate(animationController);
    animationController.forward();
  }

  void goToHome() {
    Future.delayed(const Duration(seconds: 3), () {
      context.read<AuthCubit>().isAuthenticated();
    });
  }

  @override
  void initState() {
    initAnimation();
    goToHome();
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          GoRouter.of(context).goNamed('home');
        } else if (state is UnAuthenticated) {
          GoRouter.of(context).goNamed('intro');
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset(
            PrefsService.loadTheme() == 1 ? Constants.logoDark : Constants.logo,
            height: height * 0.4,
            width: width * 0.5,
          ),
          AnimatedBuilder(
            builder:
                (context, child) => SlideTransition(
                  position: slideAnimation,
                  child: Text(
                    "Keep it clean, keep it green!",
                    textAlign: TextAlign.center,
                    style: MyStyle.title25(context),
                  ),
                ),
            animation: slideAnimation,
          ),
        ],
      ),
    );
  }
}
