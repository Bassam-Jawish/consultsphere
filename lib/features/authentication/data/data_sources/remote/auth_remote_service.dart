import 'package:consultsphere/core/resources/data_state.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRemoteService {
  Future<UserCredential> register(
    String name,
    String gender,
    String email,
    String phoneNumber,
    String password,
  );

  Future<UserCredential> login(String email, String password);

  Future<void> sendEmailVerification ();

  Future<void> sendPasswordResetEmail (String email);

  Future<UserCredential> signInWithGoogle();

  Future<UserCredential> signInWithFacebook();

  Future<UserCredential> signInWithApple();

  Future<void> signOut();

  Future<String> getCurrentUID();

  Future<bool> isSignIn();

/*Future<void> verifyPhoneNumber(String phoneNumber);
  Future<void> signInWithPhoneNumber(String smsPinCode);

  Future<void> signOut();*/
}
