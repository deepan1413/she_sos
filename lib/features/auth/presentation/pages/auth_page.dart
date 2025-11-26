import 'package:flutter/material.dart';
import 'package:she_sos/features/auth/presentation/pages/login_page.dart';
import 'package:she_sos/features/auth/presentation/pages/register_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool showPage = true;
  void togglePage() {
    setState(() {
      showPage = !showPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showPage) {
      return LoginPage(
        togglePage: togglePage,
      );
    } else {
      return RegisterPage(
        togglePage: togglePage,

      );
    }
    ;
  }
}
