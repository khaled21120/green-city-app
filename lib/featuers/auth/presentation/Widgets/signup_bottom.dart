import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:green_city/generated/l10n.dart';

import '../../../../core/utils/text_style.dart';
import '../../../../core/utils/button.dart';
import '../../../../core/utils/text_felid.dart';
import '../../cubits/SignUp/sign_up_cubit.dart';

class SignUpBottom extends StatefulWidget {
  const SignUpBottom({super.key});

  @override
  State<SignUpBottom> createState() => _SignUpBottomState();
}

class _SignUpBottomState extends State<SignUpBottom> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  bool visibility = true;
  void signUp(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<SignUpCubit>().signUp(
        email: emailController.text,
        password: passwordController.text,
        address: addressController.text,
        phone: phoneController.text,
        name: nameController.text,
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
    nameController.dispose();
    phoneController.dispose();
    addressController.dispose();
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
        height: MediaQuery.sizeOf(context).height * 0.7,
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
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 15,
            bottom: 10,
          ),
          child: Column(
            spacing: 8,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Text
              Text(
                S.of(context).create_account,
                style: MyStyle.title30(context),
              ),
              Text(
                S.of(context).sign_up_to_continue,
                style: MyStyle.title16(context),
              ),

              // Name Text Felid
              MyTextFelid(
                label: S.of(context).name,
                controller: nameController,
                keyboardType: TextInputType.name,
              ),

              // Phone Text Felid
              MyTextFelid(
                label: S.of(context).phone_number,
                controller: phoneController,
                keyboardType: TextInputType.phone,
              ),

              // Address Text Felid
              MyTextFelid(
                label: S.of(context).address,
                controller: addressController,
                keyboardType: TextInputType.text,
              ),

              // Email Text Felid
              MyTextFelid(
                label: S.of(context).email,
                controller: emailController,
              ),

              // Password Text Felid
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

              const Spacer(),
              // Sign Up Button
              Center(
                child: MyButton(
                  text: S.of(context).sign_up,
                  onTap: () => signUp(context),
                ),
              ),

              // Already have an account
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    S.of(context).already_have_an_account,
                    style: MyStyle.title16(context),
                  ),
                  TextButton(
                    onPressed: () => GoRouter.of(context).goNamed('login'),
                    child: Text(
                      S.of(context).sign_in,
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
