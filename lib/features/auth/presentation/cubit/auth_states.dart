import 'package:movies/features/auth/domain/entity/user_entity.dart';

abstract class AuthStates{}

class AuthInitialState extends AuthStates{}

class LoginLoadingState extends AuthStates{}
class LoginSuccessState extends AuthStates {}
class LoginErrorState extends AuthStates {
  final String error;
  LoginErrorState(this.error);
}

class RegisterLoadingState extends AuthStates{}
class RegisterSuccessState extends AuthStates {}
class RegisterErrorState extends AuthStates {
  final String error;
  RegisterErrorState(this.error);
}


class ProfileLoading extends AuthStates {}
class ProfileLoaded extends AuthStates {
  final UserEntity user;

  ProfileLoaded(this.user);
}
class ProfileEmpty extends AuthStates {}
class ProfileUnauthenticated extends AuthStates {}
class ProfileError extends AuthStates {
  final String message;

  ProfileError(this.message);
}
class ProfileLoggedOut extends AuthStates {}
