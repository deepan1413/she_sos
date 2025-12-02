import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:she_sos/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:she_sos/features/auth/presentation/cubit/auth_states.dart';
import 'package:she_sos/features/auth/domain/entitites/app_user.dart';

class ProfilePage extends StatefulWidget {
  final String uid;

  const ProfilePage({super.key, required this.uid});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final authCubit = context.read<AuthCubit>();
  late AppUser? appUser = authCubit.currentUser;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is Authenticated) {
          final AppUser user = state.user;

          return Scaffold(
            appBar: AppBar(
              title:  Text("My Profile${appUser}"),
              actions: [
                IconButton(
                  icon: const Icon(Icons.logout),
                  onPressed: () {
                    context.read<AuthCubit>().logout();
                  },
                ),
              ],
            ),
             );
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}

class ProfileTile extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const ProfileTile({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(value),
      ),
    );
  }
}
