import 'package:consultsphere/core/resources/data_state.dart';
import 'package:consultsphere/core/usecases/usecase.dart';
import 'package:consultsphere/features/authentication/domain/repository/auth_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignInWithAppleUseCase implements UseCase<DataState<UserCredential>, NoParams> {
  final AuthRepository authRepository;

  SignInWithAppleUseCase(this.authRepository);

  @override
  Future<DataState<UserCredential>> call({NoParams? params}) {
    return authRepository.signInWithApple();
  }
}