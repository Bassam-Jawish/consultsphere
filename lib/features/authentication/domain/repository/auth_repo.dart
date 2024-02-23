import 'package:consultsphere/core/resources/data_state.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  // API methods
  Future<DataState<UserCredential>> login(String email, String password);

  Future<DataState<UserCredential>> register(
    String name,
    String gender,
    String email,
    String phoneNumber,
    String password,
  );

  Future<DataState<void>> sendEmailVerification();

  Future<DataState<void>> sendPasswordResetEmail(String email);

  Future<DataState<UserCredential>> signInWithGoogle();

  Future<DataState<UserCredential>> signInWithFacebook();

  Future<DataState<UserCredential>> signInWithApple();

  Future<DataState<void>> signOut();

  Future<String> getCurrentUID();

  Future<bool> isSignIn();
}
