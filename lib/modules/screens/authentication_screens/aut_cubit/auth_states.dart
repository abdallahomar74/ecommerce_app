abstract class AuthStates {}

final class AuthInitialState extends AuthStates {}

final class RegisterLoadingState extends AuthStates {}

final class RegisterSuccessState extends AuthStates {}

final class FailedToRegisterState extends AuthStates {
  String message;
  FailedToRegisterState({required this.message });
}

final class LoginLoadingState extends AuthStates{}

final class LoginSuccessState extends AuthStates{}

final class FailedToLoginState extends AuthStates{
 final String message;
 FailedToLoginState({required this.message });
}