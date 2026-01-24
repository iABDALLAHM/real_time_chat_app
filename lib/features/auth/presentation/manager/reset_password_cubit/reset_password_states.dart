abstract class ResetPasswordStates {}

final class InitialResetPasswordState extends ResetPasswordStates {}

final class LoadingResetPasswordState extends ResetPasswordStates {}

final class SuccessResetPasswordState extends ResetPasswordStates {}

final class FailureResetPasswordState extends ResetPasswordStates {
  final String errMessage;

  FailureResetPasswordState({required this.errMessage});
}
