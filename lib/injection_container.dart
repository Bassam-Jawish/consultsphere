import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultsphere/core/utils/bloc_observer.dart';
import 'package:consultsphere/features/authentication/data/data_sources/remote/auth_remote_service.dart';
import 'package:consultsphere/features/authentication/data/data_sources/remote/auth_remote_service_impl.dart';
import 'package:consultsphere/features/authentication/data/repository/auth_repo_impl.dart';
import 'package:consultsphere/features/authentication/domain/repository/auth_repo.dart';
import 'package:consultsphere/features/authentication/domain/usecases/email_verification_usecase.dart';
import 'package:consultsphere/features/authentication/domain/usecases/reset_password_usecase.dart';
import 'package:consultsphere/features/authentication/domain/usecases/sign_in_with_Apple_usecase.dart';
import 'package:consultsphere/features/authentication/domain/usecases/sign_in_with_facebook_usecase.dart';
import 'package:consultsphere/features/authentication/domain/usecases/sign_in_with_google_usecase.dart';
import 'package:consultsphere/features/authentication/domain/usecases/signout_usecase.dart';
import 'package:consultsphere/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'core/network/network_info.dart';
import 'core/utils/cache_helper.dart';
import 'features/authentication/domain/usecases/login_usecase.dart';
import 'features/authentication/domain/usecases/register_usecase.dart';
import 'features/authentication/presentation/bloc/auth/remote/auth_bloc.dart';

final sl = GetIt.instance;

var token;

var routePath;

UserCredential? userCredential;

Future<void> initializeDependencies() async {
  //final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  //sl.registerSingleton<AppDatabase>(database);

  // Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Bloc Observer

  Bloc.observer = MyBlocObserver();

  // Shared Preferences

  await CacheHelper.init();

  // Secure Storage

  SecureStorage.initStorage();

  token = await SecureStorage.readSecureData(key: 'token') ?? '';

  print(token);

  // Register instances of FirebaseFirestore and FirebaseAuth and GoogleSignIn and FacebookAuth
  sl.registerSingleton<FirebaseFirestore>(FirebaseFirestore.instance);
  sl.registerSingleton<FirebaseAuth>(FirebaseAuth.instance);
  sl.registerSingleton<GoogleSignIn>(GoogleSignIn());
  sl.registerSingleton<FacebookAuth>(FacebookAuth.instance);

  // Dependencies
  sl.registerSingleton<AuthRemoteService>(AuthRemoteServiceImpl(
      fireStore: sl<FirebaseFirestore>(),
      auth: sl<FirebaseAuth>(),
      googleSignIn: sl<GoogleSignIn>(),
      facebookSignIn: sl<FacebookAuth>()));

  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl(sl()));

  // UseCases
  sl.registerSingleton<LoginUseCase>(LoginUseCase(sl()));
  sl.registerSingleton<RegisterUseCase>(RegisterUseCase(sl()));
  sl.registerSingleton<EmailVerificationUseCase>(
      EmailVerificationUseCase(sl()));
  sl.registerSingleton<ResetPasswordUseCase>(ResetPasswordUseCase(sl()));
  sl.registerSingleton<SignInWithGoogleUseCase>(SignInWithGoogleUseCase(sl()));
  sl.registerSingleton<SignInWithFacebookUseCase>(
      SignInWithFacebookUseCase(sl()));
  sl.registerSingleton<SignInWithAppleUseCase>(SignInWithAppleUseCase(sl()));
  sl.registerSingleton<SignOutUseCase>(SignOutUseCase(sl()));

  // Network
  sl.registerSingleton<NetworkInfo>(
    NetworkInfoImpl(InternetConnectionChecker()),
  );

  // Bloc
  sl.registerFactory<AuthBloc>(() => AuthBloc(
        sl<LoginUseCase>(),
        sl<RegisterUseCase>(),
        sl<NetworkInfo>(),
        sl<EmailVerificationUseCase>(),
        sl<ResetPasswordUseCase>(),
        sl<SignInWithGoogleUseCase>(),
        sl<SignInWithFacebookUseCase>(),
        sl<SignInWithAppleUseCase>(),
        sl<SignOutUseCase>(),
      ));
  //sl.registerFactory<HomeBloc>(() => HomeBloc(sl<NetworkInfo>()));
  //sl.registerFactory<CategoryBloc>(() => CategoryBloc(sl<NetworkInfo>()));
}
