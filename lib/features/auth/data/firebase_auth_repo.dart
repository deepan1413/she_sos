import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:she_sos/features/auth/domain/entitites/app_user.dart';
import 'package:she_sos/features/auth/domain/repos/auth_repo.dart';
import 'package:she_sos/myLogs/mylogs.dart';

class FirebaseAuthRepo implements AuthRepo {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static const _onboardingKey = 'onboarding_complete';
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
  bool _isGoogleInitialized = false;

  Future<void> _initializeGoogleSignIn() async {
    if (!_isGoogleInitialized) {
      await _googleSignIn.initialize();
      _isGoogleInitialized = true;
    }
  }

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
  Future<void> logout() async {
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
      AppUser user = AppUser(
        email: email,
        uid: userCredential.user!.uid,
        name: name,
      );
      await firebaseFirestore.collection('users').doc().set(user.toJson());
      return user;
    } catch (e) {
      MyLog.error(e.toString());
    }
  }

  @override
  Future<String> sendPasswordResetEmail(String email) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
      return 'password reset link sent sucessfully';
    } catch (e) {
      return 'An error occured : $e';
    }
  }

  @override
  Future<AppUser?> signInWithGoogle() async {
    try {
      await _initializeGoogleSignIn();

      final GoogleSignInAccount? googleUser = await _googleSignIn.authenticate(
        scopeHint: ['email'],
      );

      if (googleUser == null) {
        return null;
      }

      final GoogleSignInClientAuthorization? authorization = await googleUser
          .authorizationClient
          .authorizationForScopes(['email', 'profile']);

      final idToken = googleUser.authentication.idToken;
      final accessToken = authorization?.accessToken;

      final credential = GoogleAuthProvider.credential(
        idToken: idToken,
        accessToken: accessToken,
      );

      final userCredential = await firebaseAuth.signInWithCredential(
        credential,
      );
      final user = userCredential.user;
      if (user == null) return null;

      return AppUser(uid: user.uid, email: user.email ?? '');
    } catch (e) {
      MyLog.error(e.toString());

      return null;
    }
  }
}
