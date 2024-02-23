
import 'package:consultsphere/core/resources/data_state.dart';
import 'package:consultsphere/core/usecases/usecase.dart';
import 'package:consultsphere/features/authentication/domain/repository/auth_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';


class LoginUseCase implements UseCase<DataState<UserCredential>, LoginParams> {
  final AuthRepository authRepository;

  LoginUseCase(this.authRepository);

  @override
  Future<DataState<UserCredential>> call({LoginParams? params}) {
    return authRepository.login(params!.email, params.password);
  }
}

class LoginParams {
  final String email;
  final String password;

  LoginParams({required this.email, required this.password});
}