import 'package:firebase_auth/firebase_auth.dart';
import 'package:she_sos/features/auth/domain/entitites/app_user.dart';
import 'package:she_sos/features/auth/domain/repos/auth_repo.dart';
import 'package:she_sos/myLogs/mylogs.dart';

class FirebaseAuthRepo implements AuthRepo {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  @override
  Future<AppUser?> getCurrentUser() async {
    try {
      final FirebaseUser = firebaseAuth.currentUser;
      if (FirebaseUser == null) return null;
      return AppUser(email: FirebaseUser.email!, uid: FirebaseUser.uid);
    } catch (e) {
      MyLog.error(e.toString());
    }
  }

  @override
  Future<AppUser?> loginWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      AppUser user = AppUser(email: email, uid: userCredential.user!.uid);
      return user;
    } catch (e) {
      MyLog.error(e.toString());
    }
  }

  @override
  Future<void> logout()async {
    
   await firebaseAuth.signOut();  
  }

  @override
  Future<AppUser?> registerWithEmailAndPassword(
    String name,
    String email,
    String password,
  ) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      AppUser user = AppUser(email: email, uid: userCredential.user!.uid);
      return user;
    } catch (e) {
      MyLog.error(e.toString());
    }
  }

  @override
  Future<String> sendPasswordResetEmail(String email)async {
   try {
     await firebaseAuth.sendPasswordResetEmail(email:   email);
     return 'password reset link sent sucessfully';
   } catch (e) {
     return 'An error occured : $e';
   }
  }
}
