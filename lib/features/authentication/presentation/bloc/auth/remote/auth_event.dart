part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {
  const AuthEvent();
}

class Login extends AuthEvent {
  final String email;
  final String password;

  const Login(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

class Register extends AuthEvent {
  final String name;
  final String gender;
  final String email;
  final String phoneNumber;
  final String password;
  final String confirmPassword;

  const Register(this.name, this.gender, this.email, this.phoneNumber, this.password, this.confirmPassword);

  @override
  List<Object> get props => [name, gender, email, phoneNumber, password, confirmPassword];

}

class SendEmailVerification extends AuthEvent{
  const SendEmailVerification();
}

class ResetPassword extends AuthEvent{
  final String email;

  const ResetPassword(this.email);

  @override
  List<Object> get props => [email];
}

class SignInWithGoogle extends AuthEvent{
  const SignInWithGoogle();
}

class SignInWithFacebook extends AuthEvent{
  const SignInWithFacebook();
}

class SignInWithApple extends AuthEvent{
  const SignInWithApple();
}

class SignOut extends AuthEvent{
  const SignOut();
}

class ChangePassword extends AuthEvent{
  const ChangePassword();
}

class ChangeGender extends AuthEvent{
  final int selected;
  const ChangeGender(this.selected);
}

class ChangeAgree extends AuthEvent{
  const ChangeAgree();
}