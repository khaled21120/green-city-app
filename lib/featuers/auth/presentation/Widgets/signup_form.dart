import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:green_city/generated/l10n.dart';

import '../../../../core/utils/text_style.dart';
import '../../../../core/widgets/button.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../cubits/sign_up/sign_up_cubit.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  var _autovalidateMode = AutovalidateMode.disabled;
  var _obscurePassword = true;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: _autovalidateMode,
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height * 0.7,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              const SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildNameField(),
                      const SizedBox(height: 16),
                      _buildPhoneField(),
                      const SizedBox(height: 16),
                      _buildAddressField(),
                      const SizedBox(height: 16),
                      _buildEmailField(),
                      const SizedBox(height: 16),
                      _buildPasswordField(),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
              _buildSignUpButton(context),
              _buildLoginPrompt(context),
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
        Text(S.of(context).create_account, style: MyStyle.title30(context)),
        Text(
          S.of(context).sign_up_to_continue,
          style: MyStyle.title16(context).copyWith(
            color: Theme.of(
              context,
            ).colorScheme.onSurface.withValues(alpha: 0.6),
          ),
        ),
      ],
    );
  }

  Widget _buildNameField() {
    return AuthTextField(
      labelText: S.of(context).name,
      controller: _nameController,
      keyboardType: TextInputType.name,
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your name';
        }
        if (value.length < 2) {
          return 'Name must be at least 2 characters';
        }
        return null;
      },
    );
  }

  Widget _buildPhoneField() {
    return AuthTextField(
      labelText: S.of(context).phone_number,
      controller: _phoneController,
      keyboardType: TextInputType.phone,
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your phone number';
        }
        // Basic international phone number validation
        final phoneRegex = RegExp(
          r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$',
        );
        if (!phoneRegex.hasMatch(value)) {
          return 'Enter a valid phone number';
        }
        if (value.length < 8) {
          return 'Phone number too short';
        }
        return null;
      },
    );
  }

  Widget _buildAddressField() {
    return AuthTextField(
      labelText: S.of(context).address,
      controller: _addressController,
      keyboardType: TextInputType.streetAddress,
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your address';
        }
        if (value.length < 10) {
          return 'Address must be at least 10 characters';
        }
        return null;
      },
    );
  }

  Widget _buildEmailField() {
    return AuthTextField(
      labelText: S.of(context).email,
      controller: _emailController,
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

  Widget _buildSignUpButton(BuildContext context) {
    return Center(
      child: MyButton(text: S.of(context).sign_up, onTap: _submitForm),
    );
  }

  Widget _buildLoginPrompt(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: TextButton(
          onPressed: () => GoRouter.of(context).goNamed('login'),
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
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      context.read<SignUpCubit>().signUp(
        name: _nameController.text.trim(),
        phone: _phoneController.text.trim(),
        address: _addressController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
    } else {
      setState(() => _autovalidateMode = AutovalidateMode.always);
    }
  }
}
