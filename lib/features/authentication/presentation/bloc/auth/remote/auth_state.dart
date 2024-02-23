part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  final bool? status;
  final Failure? error;
  final bool? isLoading;
  final bool? isPasswordVis;
  final int? groupValue;
  final bool? agreeCheckBox;
  final UserCredential? userCredential;
  final bool? isRegister;

  const AuthState(
      {this.status,
      this.error,
      this.isLoading,
      this.isPasswordVis,
      this.groupValue,
      this.agreeCheckBox,
      this.userCredential,
      this.isRegister});

  @override
  List<Object?> get props => [
        error,
        isLoading,
        isPasswordVis,
        groupValue,
        agreeCheckBox,
        userCredential,
        isRegister
      ];

/*AuthState copyWith({
    bool? status,
    Failure? error,
    bool? isLoading,
    bool? isPasswordVis,
    int? groupValue,
    bool? agreeCheckBox,
    UserCredential? userCredential,
    bool? isRegister,
  });*/
}

class AuthInitial extends AuthState {
  const AuthInitial(
      int groupValue, bool isPasswordVis, bool isLoading, bool agreeCheckBox)
      : super(
            isLoading: isLoading,
            groupValue: groupValue,
            isPasswordVis: isPasswordVis,
            agreeCheckBox: agreeCheckBox);
}

class AuthLoading extends AuthState {
  const AuthLoading(
      int groupValue, bool isPasswordVis, bool isLoading, bool agreeCheckBox)
      : super(
            isLoading: isLoading,
            groupValue: groupValue,
            isPasswordVis: isPasswordVis,
            agreeCheckBox: agreeCheckBox);
}

class AuthSuccess extends AuthState {
  const AuthSuccess(
      {required int groupValue,
      required bool isPasswordVis,
      required bool status,
      required bool isLoading,
      required bool agreeCheckBox,
      required UserCredential userCredential,
      required bool isRegister})
      : super(
            status: status,
            isLoading: isLoading,
            groupValue: groupValue,
            isPasswordVis: isPasswordVis,
            agreeCheckBox: agreeCheckBox,
            userCredential: userCredential,
            isRegister: isRegister);
}

class AuthError extends AuthState {
  const AuthError(
      {required int groupValue,
      required bool isPasswordVis,
      required Failure error,
      required bool isLoading,
      required bool agreeCheckBox})
      : super(
            groupValue: groupValue,
            isPasswordVis: isPasswordVis,
            error: error,
            isLoading: isLoading,
            agreeCheckBox: agreeCheckBox);
}

class ChangePasswordState extends AuthState {
  const ChangePasswordState(
      int groupValue, bool isPasswordVis, bool isLoading, bool agreeCheckBox)
      : super(
            groupValue: groupValue,
            isPasswordVis: isPasswordVis,
            isLoading: isLoading,
            agreeCheckBox: agreeCheckBox);
}

class ChangeGenderState extends AuthState {
  const ChangeGenderState(
      int groupValue, bool isPasswordVis, bool isLoading, bool agreeCheckBox)
      : super(
            groupValue: groupValue,
            isPasswordVis: isPasswordVis,
            isLoading: isLoading,
            agreeCheckBox: agreeCheckBox);
}

class AgreeState extends AuthState {
  const AgreeState(
      int groupValue, bool isPasswordVis, bool isLoading, bool agreeCheckBox)
      : super(
            groupValue: groupValue,
            isPasswordVis: isPasswordVis,
            isLoading: isLoading,
            agreeCheckBox: agreeCheckBox);
}

class SendVerifyEmailSuccess extends AuthState {
  const SendVerifyEmailSuccess(
      int groupValue, bool isPasswordVis, bool isLoading, bool agreeCheckBox)
      : super(
            isLoading: isLoading,
            groupValue: groupValue,
            isPasswordVis: isPasswordVis,
            agreeCheckBox: agreeCheckBox);
}

class SendVerifyEmailError extends AuthState {
  const SendVerifyEmailError(
    int groupValue,
    bool isPasswordVis,
    Failure error,
    bool isLoading,
    bool agreeCheckBox,
  ) : super(
            groupValue: groupValue,
            isPasswordVis: isPasswordVis,
            error: error,
            isLoading: isLoading,
            agreeCheckBox: agreeCheckBox);
}

class EmailNotVerified extends AuthState {
  const EmailNotVerified(
    int groupValue,
    bool isPasswordVis,
    bool isLoading,
    bool agreeCheckBox,
  ) : super(
            groupValue: groupValue,
            isPasswordVis: isPasswordVis,
            isLoading: isLoading,
            agreeCheckBox: agreeCheckBox);
}

class ResetPasswordLoading extends AuthState {
  const ResetPasswordLoading(
      int groupValue, bool isPasswordVis, bool isLoading, bool agreeCheckBox)
      : super(
            groupValue: groupValue,
            isPasswordVis: isPasswordVis,
            isLoading: isLoading,
            agreeCheckBox: agreeCheckBox);
}

class ResetPasswordSuccess extends AuthState {
  const ResetPasswordSuccess(
      int groupValue, bool isPasswordVis, bool isLoading, bool agreeCheckBox)
      : super(
            isLoading: isLoading,
            groupValue: groupValue,
            isPasswordVis: isPasswordVis,
            agreeCheckBox: agreeCheckBox);
}

class ResetPasswordError extends AuthState {
  const ResetPasswordError(
    int groupValue,
    bool isPasswordVis,
    Failure error,
    bool isLoading,
    bool agreeCheckBox,
  ) : super(
            groupValue: groupValue,
            isPasswordVis: isPasswordVis,
            error: error,
            isLoading: isLoading,
            agreeCheckBox: agreeCheckBox);
}

class SignOutLoading extends AuthState {
  const SignOutLoading(
      int groupValue, bool isPasswordVis, bool isLoading, bool agreeCheckBox)
      : super(
            groupValue: groupValue,
            isPasswordVis: isPasswordVis,
            isLoading: isLoading,
            agreeCheckBox: agreeCheckBox);
}

class SignOutSuccess extends AuthState {
  const SignOutSuccess(
      int groupValue, bool isPasswordVis, bool isLoading, bool agreeCheckBox)
      : super(
            isLoading: isLoading,
            groupValue: groupValue,
            isPasswordVis: isPasswordVis,
            agreeCheckBox: agreeCheckBox);
}

class SignOutError extends AuthState {
  const SignOutError(
    int groupValue,
    bool isPasswordVis,
    Failure error,
    bool isLoading,
    bool agreeCheckBox,
  ) : super(
            groupValue: groupValue,
            isPasswordVis: isPasswordVis,
            error: error,
            isLoading: isLoading,
            agreeCheckBox: agreeCheckBox);
}
