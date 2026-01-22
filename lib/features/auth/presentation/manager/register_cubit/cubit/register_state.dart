abstract class RegisterStates {}

final class InitialRegisterState extends RegisterStates {}

final class SuccessRegisterState extends RegisterStates {}

final class LoadingRegisterState extends RegisterStates {}

final class FailureRegisterState extends RegisterStates {
  final String errMessage;

  FailureRegisterState({required this.errMessage});
  
}

