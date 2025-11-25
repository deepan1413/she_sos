import 'package:she_sos/features/auth/domain/entitites/app_user.dart';

abstract class AuthState {

}
class AuthInitial extends AuthState{

}

class AuthLoading extends AuthState{

}

class Authenticated extends AuthState{
  final AppUser user;
  Authenticated(this.user);
}


class Unauthenticated extends AuthState{}
class Autherror extends AuthState{
  final String message;
  Autherror(this.message);
}
