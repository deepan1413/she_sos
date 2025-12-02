import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:she_sos/features/auth/domain/entitites/app_user.dart';
import 'package:she_sos/features/auth/domain/repos/auth_repo.dart';
import 'package:she_sos/features/auth/presentation/cubit/auth_states.dart';
import 'package:she_sos/myLogs/mylogs.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo authRepo;
  AppUser? _currentuser;

  AuthCubit({required this.authRepo}) : super(AuthInitial());
  AppUser? get currentUser => _currentuser;
  void checkAuth() async {
    emit(AuthLoading());
    MyLog.info("AuthLoading on CheckAuth");
    final AppUser? user = await authRepo.getCurrentUser();
    if (user != null) {
      _currentuser = user;
      emit(Authenticated(user));
    } else {
      emit(Unauthenticated());
    }
  }

  Future<void> login(String email, String password) async {
    try {
      MyLog.info("AuthLoading on Login");
      emit(AuthLoading());

      final user = await authRepo.loginWithEmailAndPassword(email, password);
      if (user != null) {
        _currentuser = user;
        emit(Authenticated(user));
      } else {
        emit(AuthError("Invalid email or password"));
        emit(Unauthenticated());
      }
    } catch (e) {
      AuthError('Auth Error : $e');
      emit(Unauthenticated());
    }
  }

  Future<void> register(
    String name,
    String email,
    
   

    String password,
  ) async {
    try {
      emit(AuthLoading());
      MyLog.info("AuthLoading on Register");

      final user = await authRepo.registerWithEmailAndPassword(
        name,
        email,
      
        password
      );
      if (user != null) {
        _currentuser = user;
        emit(Authenticated(user));
      } else {
        emit(Unauthenticated());
      }
    } catch (e) {
      AuthError('Auth Error : $e');
      emit(Unauthenticated());
    }
  }

  Future<void> logout() async {
    emit(AuthLoading());
    MyLog.info("AuthLoading on Logout");

    await authRepo.logout();
    emit(Unauthenticated());
  }

  Future<String> forgetpassword(String email) async {
    try {
      final message = await authRepo.sendPasswordResetEmail(email);
      return message;
    } catch (e) {
      return "Error at logut $e";
    }
  }

  Future<void> signInwithGoogle() async {
    try {
      emit(AuthLoading());
      final user = await authRepo.signInWithGoogle();
      if (user != null) {
        _currentuser = user;
        emit(Authenticated(user));
      } else {
        emit(Unauthenticated());
      }
    } catch (e) {
      AuthError('Auth Error : $e');
      emit(Unauthenticated());
    }
  }
}
