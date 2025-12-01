import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:she_sos/features/auth/presentation/components/my_button.dart';
import 'package:she_sos/features/auth/presentation/components/my_textfield.dart';
import 'package:she_sos/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:she_sos/features/auth/presentation/cubit/auth_states.dart';
import 'package:she_sos/myLogs/mylogs.dart';


class LoginPage extends StatefulWidget {
  final void Function()? togglePage;
  const LoginPage({super.key, required this.togglePage});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isForgetPassword = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> forgetPassword() async {
    final email = emailController.text.trim();
    if (email.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please enter your email')));
      return;
    }

    final authCubit = context.read<AuthCubit>();

    try {
      final message = await authCubit.forgetpassword(email);
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error sending reset email: $e')));
    }
  }
Future<void> login() async {
  MyLog.highlight("Try in to login");
  final email = emailController.text.trim();
  final password = passwordController.text.trim();
  final authCubit = context.read<AuthCubit>();

  if (email.isEmpty || password.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Please enter email and password')),
    );
    return;
  }

  await authCubit.login(email, password);
}


  late final authCubit = context.read<AuthCubit>();
@override
Widget build(BuildContext context) {
  return BlocListener<AuthCubit, AuthState>(
    listener: (context, state) {
      final state = authCubit.state;
      
      if (state is AuthError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(state.message)),
        );
      }

      if (state is Authenticated) {
        
      }
    },
    child: Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.girl, size: 100),
              Text(
                "SHE SOS",
                style: TextStyle(
                  fontSize: 22,
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              MyTextfield(
                controller: emailController,
                hintText: 'Email',
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 12),
              isForgetPassword
                  ? const SizedBox.shrink()
                  : MyTextfield(
                      controller: passwordController,
                      hintText: 'Password',
                      obscureText: true,
                    ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isForgetPassword = !isForgetPassword;
                      });
                    },
                    child: Text(
                      "Forget password",
                      style: TextStyle(
                        fontSize: 15,
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              MyButton(
                name: isForgetPassword ? "Reset Password" : 'LOGIN',
                ontap: isForgetPassword ? forgetPassword : login,
              ),
              GestureDetector(
                onDoubleTap: widget.togglePage,
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Create account",
                    style: TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  borderRadius: BorderRadius.circular(8),
                  child: InkWell(
                    onTap: () async {
                      authCubit.signInwithGoogle();
                    },
                    borderRadius: BorderRadius.circular(8),
                    splashColor: Colors.white.withOpacity(0.2),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/google_logo.png',
                              height: 24,
                              width: 24,
                            ),
                            const Text(
                              '  continue with Google',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
}