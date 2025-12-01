import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:she_sos/features/auth/presentation/cubit/auth_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Future <void> logout()async{
    final authCubit = context.read<AuthCubit>();
    authCubit.logout();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: logout,
            icon: Icon(Icons.outlet_outlined),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: .center,
        children: [Center(child: Text('HomePage'))],
      ),
    );
  }
}
