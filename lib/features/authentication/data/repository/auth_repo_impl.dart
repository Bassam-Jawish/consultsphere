import 'package:consultsphere/core/resources/data_state.dart';
import 'package:consultsphere/features/authentication/data/data_sources/remote/auth_remote_service.dart';
import 'package:consultsphere/features/authentication/domain/repository/auth_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteService _authRemoteService;

  AuthRepositoryImpl(
    this._authRemoteService,
  );

  @override
  Future<DataState<UserCredential>> register(
    String name,
    String gender,
    String email,
    String phoneNumber,
    String password,
  ) async {
    try {
      final firebaseResponse = await _authRemoteService.register(
        name,
        gender,
        email,
        phoneNumber,
        password,
      );
      return DataSuccess(firebaseResponse);
    } on FirebaseException catch (e) {
      return DataFailed(e);
    } catch (e) {
      print('dfgsgfdgs');
      return DataFailed(e.toString() as FirebaseException);
    }
  }

  @override
  Future<DataState<UserCredential>> login(String email, String password) async {
    try {
      final firebaseResponse = await _authRemoteService.login(email, password);
      return DataSuccess(firebaseResponse);
    } on FirebaseException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<void>> sendEmailVerification() async {
    try {
      final firebaseResponse = _authRemoteService.sendEmailVerification();
      return DataSuccess(firebaseResponse);
    } on FirebaseException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<void>> sendPasswordResetEmail(String email) async {
    try {
      final firebaseResponse = _authRemoteService.sendPasswordResetEmail(email);
      return DataSuccess(firebaseResponse);
    } on FirebaseException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<UserCredential>> signInWithGoogle() async {
    try {
      final firebaseResponse = await _authRemoteService.signInWithGoogle();
      return DataSuccess(firebaseResponse);
    } on FirebaseException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<UserCredential>> signInWithFacebook() async {
    try {
      final firebaseResponse = await _authRemoteService.signInWithFacebook();
      return DataSuccess(firebaseResponse);
    } on FirebaseException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<UserCredential>> signInWithApple() async {
    try {
      final firebaseResponse = await _authRemoteService.signInWithApple();
      return DataSuccess(firebaseResponse);
    } on FirebaseException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<void>> signOut() async {
    try {
      final firebaseResponse = await _authRemoteService.signOut();
      return DataSuccess(firebaseResponse);
    } on FirebaseException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<String> getCurrentUID() async => _authRemoteService.getCurrentUID();

  @override
  Future<bool> isSignIn() async => _authRemoteService.isSignIn();

/*@override
  Future<void> signOut() async => _authRemoteService.signOut();*/

/*@override
  Future<void> verifyPhoneNumber(String phoneNumber) async => _authRemoteService.verifyPhoneNumber(phoneNumber);*/
}
