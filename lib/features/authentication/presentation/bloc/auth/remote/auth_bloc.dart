import 'package:bloc/bloc.dart';
import 'package:consultsphere/core/resources/data_state.dart';
import 'package:consultsphere/features/authentication/domain/usecases/email_verification_usecase.dart';
import 'package:consultsphere/features/authentication/domain/usecases/reset_password_usecase.dart';
import 'package:consultsphere/features/authentication/domain/usecases/sign_in_with_Apple_usecase.dart';
import 'package:consultsphere/features/authentication/domain/usecases/sign_in_with_facebook_usecase.dart';
import 'package:consultsphere/features/authentication/domain/usecases/sign_in_with_google_usecase.dart';
import 'package:consultsphere/features/authentication/domain/usecases/signout_usecase.dart';
import 'package:consultsphere/injection_container.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/error/failure.dart';
import '../../../../../../core/network/network_info.dart';
import '../../../../domain/usecases/login_usecase.dart';
import '../../../../domain/usecases/register_usecase.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase _loginUseCase;
  final RegisterUseCase _registerUseCase;
  final EmailVerificationUseCase _emailVerificationUseCase;
  final ResetPasswordUseCase _resetPasswordUseCase;
  final SignInWithGoogleUseCase _signInWithGoogleUseCase;
  final SignInWithFacebookUseCase _signInWithFacebookUseCase;
  final SignInWithAppleUseCase _signInWithAppleUseCase;
  final SignOutUseCase _signOutUseCase;

  final NetworkInfo _networkInfo;

  AuthBloc(
      this._loginUseCase,
      this._registerUseCase,
      this._networkInfo,
      this._emailVerificationUseCase,
      this._resetPasswordUseCase,
      this._signInWithGoogleUseCase,
      this._signInWithFacebookUseCase,
      this._signInWithAppleUseCase,
      this._signOutUseCase)
      : super(const AuthInitial(0, false, false, false)) {
    on<Login>(onLogin);
    on<Register>(onRegister);
    on<SendEmailVerification>(onSendEmailVerification);
    on<ResetPassword>(onResetPassword);
    on<SignInWithGoogle>(onSignInWithGoogle);
    on<SignInWithFacebook>(onSignInWithFacebook);
    on<SignInWithApple>(onSignInWithApple);
    on<SignOut>(onSignOut);
    on<ChangePassword>(onChangeVisPassword);
    on<ChangeGender>(onChangeGender);
    on<ChangeAgree>(onChangeAgree);
  }

  void onLogin(Login event, Emitter<AuthState> emit) async {
    emit(AuthLoading(
        state.groupValue!, state.isPasswordVis!, true, state.agreeCheckBox!));

    final isConnected = await _networkInfo.isConnected;

    if (!isConnected) {
      emit(AuthError(
          groupValue: state.groupValue!,
          isPasswordVis: state.isPasswordVis!,
          error: const ConnectionFailure('No Internet Connection'),
          isLoading: false,
          agreeCheckBox: state.agreeCheckBox!));

      return;
    }

    try {
      final loginParams =
          LoginParams(email: event.email, password: event.password);

      final dataState = await _loginUseCase(params: loginParams);
      if (dataState is DataSuccess) {
        if (userCredential!.user!.emailVerified) {
          emit(AuthSuccess(
              groupValue: state.groupValue!,
              isPasswordVis: state.isPasswordVis!,
              status: true,
              isLoading: false,
              agreeCheckBox: state.agreeCheckBox!,
              userCredential: dataState.data!,
              isRegister: false));
        } else {
          emit(EmailNotVerified(state.groupValue!, state.isPasswordVis!, false,
              state.agreeCheckBox!));
        }
      }
      if (dataState is DataFailed) {
        emit(AuthError(
            groupValue: state.groupValue!,
            isPasswordVis: state.isPasswordVis!,
            error: FirebaseFailure.fromFirebaseException(dataState.error!),
            isLoading: false,
            agreeCheckBox: state.agreeCheckBox!));
      }
    } on FirebaseException catch (e) {
      debugPrint(e.toString());
      emit(AuthError(
          groupValue: state.groupValue!,
          isPasswordVis: state.isPasswordVis!,
          error: FirebaseFailure.fromFirebaseException(e),
          isLoading: false,
          agreeCheckBox: state.agreeCheckBox!));
    }
  }

  void onRegister(Register event, Emitter<AuthState> emit) async {
    emit(AuthLoading(
        state.groupValue!, state.isPasswordVis!, true, state.agreeCheckBox!));

    final isConnected = await _networkInfo.isConnected;

    if (!isConnected) {
      emit(AuthError(
        groupValue: state.groupValue!,
        isPasswordVis: state.isPasswordVis!,
        error: const ConnectionFailure('No Internet Connection'),
        isLoading: false,
        agreeCheckBox: state.agreeCheckBox!,
      ));
      return;
    }

    try {
      final registerParams = RegisterParams(
        name: event.name,
        gender: event.gender,
        email: event.email,
        phoneNumber: event.phoneNumber,
        password: event.password,
        confirmPassword: event.confirmPassword,
      );

      final dataState = await _registerUseCase(params: registerParams);
      if (dataState is DataSuccess) {
        emit(AuthSuccess(
            groupValue: state.groupValue!,
            isPasswordVis: state.isPasswordVis!,
            status: true,
            isLoading: false,
            agreeCheckBox: state.agreeCheckBox!,
            userCredential: dataState.data!,
            isRegister: true));
      }
      if (dataState is DataFailed) {
        emit(AuthError(
            groupValue: state.groupValue!,
            isPasswordVis: state.isPasswordVis!,
            error: FirebaseFailure.fromFirebaseException(dataState.error!),
            isLoading: false,
            agreeCheckBox: state.agreeCheckBox!));
      }
    } on FirebaseException catch (e) {
      debugPrint(e.toString());
      emit(AuthError(
          groupValue: state.groupValue!,
          isPasswordVis: state.isPasswordVis!,
          error: FirebaseFailure.fromFirebaseException(e),
          isLoading: false,
          agreeCheckBox: state.agreeCheckBox!));
    }
  }

  void onSendEmailVerification(
      SendEmailVerification event, Emitter<AuthState> emit) async {
    final isConnected = await _networkInfo.isConnected;

    if (!isConnected) {
      emit(SendVerifyEmailError(
          state.groupValue!,
          state.isPasswordVis!,
          const ConnectionFailure('No Internet Connection'),
          false,
          state.agreeCheckBox!));
      return;
    }

    try {
      final dataState = await _emailVerificationUseCase();
      if (dataState is DataSuccess) {
        emit(const SendVerifyEmailSuccess(0, false, false, false));
      }
      if (dataState is DataFailed) {
        emit(SendVerifyEmailError(
            state.groupValue!,
            state.isPasswordVis!,
            FirebaseFailure.fromFirebaseException(dataState.error!),
            false,
            state.agreeCheckBox!));
      }
    } on FirebaseException catch (e) {
      debugPrint(e.toString());
      emit(SendVerifyEmailError(
          state.groupValue!,
          state.isPasswordVis!,
          FirebaseFailure.fromFirebaseException(e),
          false,
          state.agreeCheckBox!));
    }
  }

  void onResetPassword(ResetPassword event, Emitter<AuthState> emit) async {
    emit(AuthLoading(
        state.groupValue!, state.isPasswordVis!, true, state.agreeCheckBox!));

    final isConnected = await _networkInfo.isConnected;

    if (!isConnected) {
      emit(ResetPasswordError(
          state.groupValue!,
          state.isPasswordVis!,
          const ConnectionFailure('No Internet Connection'),
          false,
          state.agreeCheckBox!));
      return;
    }

    try {
      final email = event.email;

      final dataState = await _resetPasswordUseCase(params: email);
      if (dataState is DataSuccess) {
        emit(const ResetPasswordSuccess(0, false, false, false));
      }
      if (dataState is DataFailed) {
        emit(ResetPasswordError(
            state.groupValue!,
            state.isPasswordVis!,
            FirebaseFailure.fromFirebaseException(dataState.error!),
            false,
            state.agreeCheckBox!));
      }
    } on FirebaseException catch (e) {
      debugPrint(e.toString());
      emit(ResetPasswordError(
          state.groupValue!,
          state.isPasswordVis!,
          FirebaseFailure.fromFirebaseException(e),
          false,
          state.agreeCheckBox!));
    }
  }

  void onSignInWithGoogle(
      SignInWithGoogle event, Emitter<AuthState> emit) async {
    emit(AuthLoading(
        state.groupValue!, state.isPasswordVis!, true, state.agreeCheckBox!));

    final isConnected = await _networkInfo.isConnected;

    if (!isConnected) {
      emit(AuthError(
        groupValue: state.groupValue!,
        isPasswordVis: state.isPasswordVis!,
        error: const ConnectionFailure('No Internet Connection'),
        isLoading: false,
        agreeCheckBox: state.agreeCheckBox!,
      ));
      return;
    }

    try {
      final dataState = await _signInWithGoogleUseCase();
      if (dataState is DataSuccess) {
        emit(AuthSuccess(
            groupValue: state.groupValue!,
            isPasswordVis: state.isPasswordVis!,
            status: true,
            isLoading: false,
            agreeCheckBox: state.agreeCheckBox!,
            userCredential: dataState.data!,
            isRegister: false));
      }
      if (dataState is DataFailed) {
        emit(AuthError(
            groupValue: state.groupValue!,
            isPasswordVis: state.isPasswordVis!,
            error: FirebaseFailure.fromFirebaseException(dataState.error!),
            isLoading: false,
            agreeCheckBox: state.agreeCheckBox!));
      }
    } on FirebaseException catch (e) {
      debugPrint(e.toString());
      emit(AuthError(
          groupValue: state.groupValue!,
          isPasswordVis: state.isPasswordVis!,
          error: FirebaseFailure.fromFirebaseException(e),
          isLoading: false,
          agreeCheckBox: state.agreeCheckBox!));
    }
  }

  void onSignInWithFacebook(
      SignInWithFacebook event, Emitter<AuthState> emit) async {
    final isConnected = await _networkInfo.isConnected;

    if (!isConnected) {
      emit(AuthError(
        groupValue: state.groupValue!,
        isPasswordVis: state.isPasswordVis!,
        error: const ConnectionFailure('No Internet Connection'),
        isLoading: false,
        agreeCheckBox: state.agreeCheckBox!,
      ));
      return;
    }

    try {
      /*emit(AuthLoading(
          state.groupValue!, state.isPasswordVis!, true, state.agreeCheckBox!));*/
      final dataState = await _signInWithFacebookUseCase();
      if (dataState is DataSuccess) {
        emit(AuthSuccess(
            groupValue: state.groupValue!,
            isPasswordVis: state.isPasswordVis!,
            status: true,
            isLoading: false,
            agreeCheckBox: state.agreeCheckBox!,
            userCredential: dataState.data!,
            isRegister: false));
      }
      if (dataState is DataFailed) {
        emit(AuthError(
            groupValue: state.groupValue!,
            isPasswordVis: state.isPasswordVis!,
            error: FirebaseFailure.fromFirebaseException(dataState.error!),
            isLoading: false,
            agreeCheckBox: state.agreeCheckBox!));
      }
    } on FirebaseException catch (e) {
      debugPrint(e.toString());
      emit(AuthError(
          groupValue: state.groupValue!,
          isPasswordVis: state.isPasswordVis!,
          error: FirebaseFailure.fromFirebaseException(e),
          isLoading: false,
          agreeCheckBox: state.agreeCheckBox!));
    }
  }

  void onSignInWithApple(SignInWithApple event, Emitter<AuthState> emit) async {
    final isConnected = await _networkInfo.isConnected;

    if (!isConnected) {
      emit(AuthError(
        groupValue: state.groupValue!,
        isPasswordVis: state.isPasswordVis!,
        error: const ConnectionFailure('No Internet Connection'),
        isLoading: false,
        agreeCheckBox: state.agreeCheckBox!,
      ));
      return;
    }

    try {
      /*emit(AuthLoading(
          state.groupValue!, state.isPasswordVis!, true, state.agreeCheckBox!));*/
      final dataState = await _signInWithAppleUseCase();
      if (dataState is DataSuccess) {
        emit(AuthSuccess(
            groupValue: state.groupValue!,
            isPasswordVis: state.isPasswordVis!,
            status: true,
            isLoading: false,
            agreeCheckBox: state.agreeCheckBox!,
            userCredential: dataState.data!,
            isRegister: false));
      }
      if (dataState is DataFailed) {
        emit(AuthError(
            groupValue: state.groupValue!,
            isPasswordVis: state.isPasswordVis!,
            error: FirebaseFailure.fromFirebaseException(dataState.error!),
            isLoading: false,
            agreeCheckBox: state.agreeCheckBox!));
      }
    } on FirebaseException catch (e) {
      debugPrint(e.toString());
      emit(AuthError(
          groupValue: state.groupValue!,
          isPasswordVis: state.isPasswordVis!,
          error: FirebaseFailure.fromFirebaseException(e),
          isLoading: false,
          agreeCheckBox: state.agreeCheckBox!));
    }
  }

  void onSignOut(SignOut event, Emitter<AuthState> emit) async {
    emit(AuthLoading(
        state.groupValue!, state.isPasswordVis!, true, state.agreeCheckBox!));

    final isConnected = await _networkInfo.isConnected;

    if (!isConnected) {
      emit(SignOutError(
        state.groupValue!,
        state.isPasswordVis!,
        const ConnectionFailure('No Internet Connection'),
        false,
        state.agreeCheckBox!,
      ));

      return;
    }

    try {
      final dataState = await _signOutUseCase();
      if (dataState is DataSuccess) {
        //emit(const SignOutSuccess(0, false, false, false));
        emit(const SignOutSuccess(0, false, false, false));
      }
      if (dataState is DataFailed) {
        emit(SignOutError(
            state.groupValue!,
            state.isPasswordVis!,
            FirebaseFailure.fromFirebaseException(dataState.error!),
            false,
            state.agreeCheckBox!));
      }
    } on FirebaseException catch (e) {
      debugPrint(e.toString());
      emit(SignOutError(
          state.groupValue!,
          state.isPasswordVis!,
          FirebaseFailure.fromFirebaseException(e),
          false,
          state.agreeCheckBox!));
    }
  }

  void onChangeVisPassword(
      ChangePassword event, Emitter<AuthState> emit) async {
    emit(ChangePasswordState(state.groupValue!, !state.isPasswordVis!,
        state.isLoading!, state.agreeCheckBox!));
  }

  void onChangeGender(ChangeGender event, Emitter<AuthState> emit) async {
    emit(ChangeGenderState(event.selected, state.isPasswordVis!,
        state.isLoading!, state.agreeCheckBox!));
  }

  void onChangeAgree(ChangeAgree event, Emitter<AuthState> emit) async {
    emit(ChangeGenderState(state.groupValue!, state.isPasswordVis!,
        state.isLoading!, !state.agreeCheckBox!));
  }
}
