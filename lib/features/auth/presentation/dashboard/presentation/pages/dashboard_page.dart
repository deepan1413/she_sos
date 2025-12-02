import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:she_sos/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:she_sos/features/help/presentation/pages/help_page.dart';
import 'package:she_sos/features/home/presentation/pages/home_page.dart';
import 'package:she_sos/features/profile/presentation/pages/profile_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _index = 0;
  late List<Widget> pages;
  String? _uid;
  Future<void> logout() async {
    final authCubit = context.read<AuthCubit>();
    authCubit.logout();
  }

  @override
  void initState() {
    super.initState();

    final currentUser = context.read<AuthCubit>().currentUser;
    _uid = currentUser!.uid;

    pages = [const HomePage(), const HelpPage(), ProfilePage(uid: _uid!)];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (i) {
          setState(() {
            _index = i;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.help), label: 'help'),

          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),

      body: pages[_index],
    );
  }
}
