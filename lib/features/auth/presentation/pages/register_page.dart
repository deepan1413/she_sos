import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:she_sos/features/auth/presentation/components/my_button.dart';
import 'package:she_sos/features/auth/presentation/components/my_textfield.dart';
import 'package:she_sos/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:she_sos/features/auth/presentation/cubit/auth_states.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? togglePage;

  const RegisterPage({super.key, required this.togglePage});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController secondpasswordController =
      TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  bool _isLoading = false;
  bool _isVolunter = false;
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    secondpasswordController.dispose();
    nameController.dispose();
    numberController.dispose();
    addressController.dispose();
    super.dispose();
  }

  Future<void> register() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = secondpasswordController.text.trim();
    final name = nameController.text.trim();
    final phone = numberController.text.trim();


    final address = addressController.text.trim();
    final authCubit = context.read<AuthCubit>();

    if (name.isEmpty ||
        email.isEmpty ||
        numberController.text.isEmpty ||
        address.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please fill all fields')));
      return;
    }

    if (password.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password must be at least 6 characters')),
      );
      return;
    }

    if (password != confirmPassword) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Passwords do not match')));
      return;
    }

    setState(() => _isLoading = true);

    try {
      await authCubit.register(
        name,
        email,
        

        password
      );

      if (!mounted) return;

      final state = authCubit.state;

      if (state is Authenticated) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Account created successfully')),
        );

        widget.togglePage?.call();
      } else if (state is AuthError) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(state.message)));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Registration failed. Please try again.'),
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Unexpected error: $e')));
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 24),
                MyTextfield(hintText: 'Name', controller: nameController),
                const SizedBox(height: 12),
                MyTextfield(
                  hintText: 'Email',
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 12),
                MyTextfield(
                  hintText: 'Phone',
                  controller: numberController,
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 12),
                MyTextfield(
                  hintText: 'Address',
                  controller: addressController,
                  maxLines: 2,
                ),
                const SizedBox(height: 12),
                MyTextfield(
                  hintText: 'Password',
                  controller: passwordController,
                  obscureText: true,
                ),
                const SizedBox(height: 12),
                MyTextfield(
                  hintText: 'Re-enter password',
                  controller: secondpasswordController,
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                MyButton(
                  name: _isLoading ? 'PLEASE WAIT...' : 'SIGN UP',
                  ontap: _isLoading ? null : register,
                ),
                GestureDetector(
                  onDoubleTap: widget.togglePage,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Already have an account?",
                      style: TextStyle(
                        fontSize: 15,
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
