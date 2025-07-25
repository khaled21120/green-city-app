// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:green_city/core/themes/light_theme.dart';
import 'package:green_city/core/utils/helper.dart';
import 'package:green_city/core/widgets/custom_text_field.dart';
import 'package:green_city/generated/l10n.dart';

import '../../../../core/errors/error.dart';
import '../../../../core/widgets/button.dart';
import '../../../../core/utils/text_style.dart';
import '../cubits/log_In/log_in_cubit.dart';

class LoginFormCard extends StatefulWidget {
  const LoginFormCard({super.key, required this.size});
  final Size size;

  @override
  State<LoginFormCard> createState() => _LoginFormCardState();
}

class _LoginFormCardState extends State<LoginFormCard> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmEmailController = TextEditingController();

  var _autovalidateMode = AutovalidateMode.disabled;
  var _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmEmailController.dispose();
    super.dispose();
  }

  void signIn(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<LogInCubit>().logIn(
        email: _emailController.text,
        password: _passwordController.text,
      );
    } else {
      setState(() {
        _autovalidateMode = AutovalidateMode.always;
      });
    }
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size.width,
      height: widget.size.height * 0.55,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Form(
          key: _formKey,
          autovalidateMode: _autovalidateMode,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              const SizedBox(height: 20),
              _buildEmailField(),
              const SizedBox(height: 16),
              _buildPasswordField(),
              _buildForgotPassword(context),
              const Spacer(),
              _buildLoginButton(context),
              _buildSignUpPrompt(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(S.of(context).sign_in, style: MyStyle.title30(context)),
        Text(
          S.of(context).sign_in_to_continue,
          style: MyStyle.title16(context).copyWith(
            color: Theme.of(
              context,
            ).colorScheme.onSurface.withValues(alpha: 0.6),
          ),
        ),
      ],
    );
  }

  Widget _buildEmailField() {
    return AuthTextField(
      controller: _emailController,
      labelText: S.of(context).email,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '${S.of(context).enter} ${S.of(context).email}';
        }
        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
          return 'Please enter a valid email';
        }
        return null;
      },
    );
  }

  Widget _buildPasswordField() {
    return AuthTextField(
      labelText: S.of(context).password,
      controller: _passwordController,
      obscureText: _obscurePassword,
      suffixIcon: IconButton(
        icon: Icon(
          _obscurePassword ? Icons.visibility_off : Icons.visibility,
          color: Colors.grey,
        ),
        onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '${S.of(context).enter} ${S.of(context).password}';
        }
        if (value.length < 8) {
          return 'Password must be at least 8 characters';
        }
        return null;
      },
    );
  }

  void _handleForgotPassword(BuildContext context) async {
    final emailController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    bool isLoading = false;

    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: Theme.of(context).colorScheme.surface,
              title: Text(S.of(context).enter_email_first),
              content: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AuthTextField(
                      controller: emailController,
                      labelText: S.of(context).email,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '${S.of(context).enter} ${S.of(context).email}';
                        }
                        if (!RegExp(
                          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                        ).hasMatch(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    if (isLoading) ...[
                      const SizedBox(height: 16),
                      const CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          MyColors.lightGrey,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: isLoading ? null : () => Navigator.pop(context),
                  child: Text(S.of(context).cancel),
                ),
                ElevatedButton(
                  onPressed:
                      isLoading
                          ? null
                          : () async {
                            if (formKey.currentState!.validate()) {
                              setState(() => isLoading = true);
                              try {
                                await context.read<LogInCubit>().forgetPassword(
                                  email: emailController.text.trim(),
                                );
                                if (mounted) {
                                  Navigator.pop(context);
                                  Helper.showSnackBar(
                                    context: context,
                                    message: S.of(context).reset_link_sent,
                                  );
                                }
                              } catch (error) {
                                if (mounted) {
                                  Helper.showSnackBar(
                                    context: context,
                                    message:
                                        error is ServerFailure
                                            ? error.errMsg
                                            : "something went wrong",
                                  );
                                }
                              } finally {
                                if (mounted) {
                                  setState(() => isLoading = false);
                                }
                              }
                            }
                          },
                  child: Text(S.of(context).submit),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildForgotPassword(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Align(
        alignment: Alignment.centerRight,
        child: TextButton(
          onPressed: () => _handleForgotPassword(context),
          child: Text(
            S.of(context).forget_password,
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return Center(
      child: MyButton(text: S.of(context).sign_in, onTap: _submitForm),
    );
  }

  Widget _buildSignUpPrompt(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () {
          GoRouter.of(context).goNamed('signup');
        },
        child: RichText(
          text: TextSpan(
            text: S.of(context).dont_have_an_account,
            style: TextStyle(color: Colors.grey.shade600),
            children: [
              TextSpan(
                text: ' ${S.of(context).sign_up}',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      context.read<LogInCubit>().logIn(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
    } else {
      setState(() => _autovalidateMode = AutovalidateMode.always);
    }
  }
}
