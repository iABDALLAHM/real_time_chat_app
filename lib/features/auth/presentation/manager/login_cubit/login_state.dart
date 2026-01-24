abstract class LoginStates {}

final class InitialLoginState extends LoginStates {}

final class LoadingLoginState extends LoginStates {}

final class SuccessLoginState extends LoginStates {}

final class FailureLoginState extends LoginStates {
  final String errMessage;

  FailureLoginState({required this.errMessage});
}
