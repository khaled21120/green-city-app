import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:green_city/core/utils/helper.dart';
import 'package:green_city/core/widgets/button.dart';
import 'package:green_city/core/widgets/custom_text_field.dart';
import 'package:green_city/generated/l10n.dart';

import '../../../core/utils/text_style.dart';
import 'cubits/log_In/log_in_cubit.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String token;
  final String email;

  const ResetPasswordScreen({
    super.key,
    required this.token,
    required this.email,
  });

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _submitNewPassword() {
    if (_formKey.currentState!.validate()) {
      context.read<LogInCubit>().resetPassword(
        token: widget.token,
        email: widget.email,
        newPassword: _passwordController.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).reset_password),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => GoRouter.of(context).pop(),
        ),
      ),
      body: BlocListener<LogInCubit, LogInState>(
        listener: (context, state) {
          if (state is ResetPasswordSuccess) {
            GoRouter.of(context).goNamed('login');
            Helper.showSnackBar(context: context, message: state.message);
          } else if (state is LogInError) {
            Helper.showSnackBar(context: context, message: state.message);
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.of(context).set_new_password,
                  style: MyStyle.title25(context),
                ),
                const SizedBox(height: 8),
                Text(
                  S.of(context).reset_password,
                  style: MyStyle.title16(context),
                ),
                const SizedBox(height: 24),
                _buildPasswordField(),
                const SizedBox(height: 16),
                _buildConfirmPasswordField(),
                const SizedBox(height: 32),
                _buildSubmitButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField() {
    return AuthTextField(
      labelText: S.of(context).new_password,
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
          return S.of(context).enter_new_password;
        }
        if (value.length < 8) {
          return S.of(context).password_min_length;
        }
        return null;
      },
    );
  }

  Widget _buildConfirmPasswordField() {
    return AuthTextField(
      labelText: S.of(context).confirm_password,
      controller: _confirmPasswordController,
      obscureText: _obscurePassword,
      suffixIcon: IconButton(
        icon: Icon(
          _obscurePassword ? Icons.visibility_off : Icons.visibility,
          color: Colors.grey,
        ),
        onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
      ),
      validator: (value) {
        if (value != _passwordController.text) {
          return S.of(context).passwords_not_match;
        }
        return null;
      },
    );
  }

  Widget _buildSubmitButton() {
    return BlocBuilder<LogInCubit, LogInState>(
      builder: (context, state) {
        return MyButton(
          text: S.of(context).reset_password,
          onTap: () => state is LogInLoading ? null : _submitNewPassword,
        );
      },
    );
  }
}
