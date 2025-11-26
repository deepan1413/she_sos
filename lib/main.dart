import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:she_sos/features/auth/data/firebase_auth_repo.dart';
import 'package:she_sos/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:she_sos/features/auth/presentation/cubit/auth_states.dart';
import 'package:she_sos/features/auth/presentation/home/pages/home_page.dart';
import 'package:she_sos/features/auth/presentation/pages/auth_page.dart';
import 'package:she_sos/firebase_options.dart';
import 'package:she_sos/myLogs/mylogs.dart';
import 'package:she_sos/themes/darkmode_theme.dart';
import 'package:she_sos/themes/lightmode_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final firebaseAuth = FirebaseAuthRepo();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(authRepo: firebaseAuth)..checkAuth(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: lightmode,
        // darkTheme: darkmode,
        home: BlocConsumer<AuthCubit, AuthState>(
          builder: (context, state) {
            MyLog.highlight("$state");
            if (state is Unauthenticated) {
              return AuthPage();
            }
            if (state is Authenticated) {
              return HomePage();
            } else {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }
          },
          listener: (context, state) {
            if (state is Autherror) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
        ),
      ),
    );
  }
}
