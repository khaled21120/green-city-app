import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:green_city/generated/l10n.dart';

import '../../../../core/widgets/button.dart';
import '../../../../core/widgets/text_felid.dart';
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
  var _autovalidateMode = AutovalidateMode.disabled;
  var _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
          ),
        ),
      ],
    );
  }

  Widget _buildEmailField() {
    return MyTextField(
      label: S.of(context).email,
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
    );
  }

  Widget _buildPasswordField() {
    return MyTextField(
      label: S.of(context).password,
      controller: _passwordController,
      isPassword: _obscurePassword,
      icon: IconButton(
        icon: Icon(
          _obscurePassword ? Icons.visibility_off : Icons.visibility,
          color: Colors.grey,
        ),
        onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
      ),
    );
  }

  Widget _buildForgotPassword(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () => GoRouter.of(context).goNamed('forgotPassword'),
        child: Text(
          S.of(context).forget_password,
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.w600,
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(S.of(context).dont_have_an_account),
        TextButton(
          onPressed: () => GoRouter.of(context).goNamed('signup'),
          child: Text(
            S.of(context).sign_up,
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      context.read<LogInCubit>().logIn(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );
    } else {
      setState(() => _autovalidateMode = AutovalidateMode.always);
    }
  }
}
