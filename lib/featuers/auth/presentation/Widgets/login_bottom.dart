import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:green_city/generated/l10n.dart';

import '../../../../core/utils/button.dart';
import '../../../../core/utils/text_felid.dart';
import '../../../../core/utils/text_style.dart';
import '../cubits/LogIn/log_in_cubit.dart';

class LogInBottom extends StatefulWidget {
  const LogInBottom({super.key});

  @override
  State<LogInBottom> createState() => _LogInBottomState();
}

class _LogInBottomState extends State<LogInBottom> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  bool visibility = true;
  void signIn(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<LogInCubit>().logIn(
        email: emailController.text,
        password: passwordController.text,
      );
    } else {
      setState(() {
        autovalidateMode = AutovalidateMode.always;
      });
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: autovalidateMode,
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height * 0.6,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
          color: Theme.of(context).colorScheme.surface,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Text
              Text(S.of(context).sign_in, style: MyStyle.title30(context)),
              Text(
                S.of(context).sign_in_to_continue,
                style: MyStyle.title16(context),
              ),
              const SizedBox(height: 20),

              // Email and Password
              MyTextFelid(
                label: S.of(context).email,
                controller: emailController,
              ),
              MyTextFelid(
                label: S.of(context).password,
                controller: passwordController,
                isPassword: visibility,
                icon: IconButton(
                  icon:
                      visibility
                          ? const Icon(Icons.visibility_sharp)
                          : const Icon(Icons.visibility_off_sharp),
                  onPressed: () {
                    setState(() {
                      visibility = !visibility;
                    });
                  },
                ),
              ),
              const SizedBox(height: 10),

              // Forgot Password
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  S.of(context).forget_password,
                  style: TextStyle(
                    fontSize: 17,
                    color: Theme.of(context).colorScheme.onSurface,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // Log In Button
              Center(
                child: MyButton(
                  text: S.of(context).sign_in,
                  onTap: () => signIn(context),
                ),
              ),
              const SizedBox(height: 20),

              // Don't have an account
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    S.of(context).dont_have_an_account,
                    style: MyStyle.title16(context),
                  ),
                  TextButton(
                    onPressed:
                        () => GoRouter.of(context).pushReplacement('/signup'),
                    child: Text(
                      S.of(context).sign_up,
                      style: TextStyle(
                        fontSize: 18,
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
