import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:green_city/core/utils/intro_button.dart';
import 'package:green_city/core/utils/text_style.dart';
import 'package:green_city/generated/l10n.dart';
import '../../../core/utils/constants.dart';
import '../../../core/themes/light_theme.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [MyColors.gradient1, MyColors.gradient2],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo Section
              Hero(
                tag: 'app-logo',
                child: Image.asset(
                  Constants.logo,
                  width: size.width * 0.6,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: size.height * 0.01),

              // Title Section
              Text(
                S.of(context).welcome_title,
                textAlign: TextAlign.center,
                style: MyStyle.title25(context).copyWith(color: Colors.white),
              ),
              SizedBox(height: size.height * 0.02),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                child: Text(
                  S.of(context).welcome_subtitle,
                  textAlign: TextAlign.center,
                  style: MyStyle.title16(
                    context,
                  ).copyWith(color: Colors.white70, height: 1.5),
                ),
              ),
              SizedBox(height: size.height * 0.06),

              // Buttons Section
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                child: Column(
                  children: [
                    // Sign In Button
                    IntroButton(
                      onTap: () => GoRouter.of(context).goNamed('login'),
                      text: S.of(context).sign_in,
                      color: MyColors.white,
                      textColor: MyColors.primary,
                      borderColor: MyColors.black,
                    ),
                    const SizedBox(height: 20),

                    // Sign Up Button
                    OutlinedButton(
                      onPressed: () => GoRouter.of(context).goNamed('signup'),
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        side: const BorderSide(color: Colors.white, width: 2),
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        S.of(context).sign_up,
                        style: const TextStyle(
                          fontSize: 20,
                          color: MyColors.white,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
