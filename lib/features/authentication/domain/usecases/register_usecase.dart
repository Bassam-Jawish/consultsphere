import 'package:consultsphere/core/resources/data_state.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/usecases/usecase.dart';
import '../repository/auth_repo.dart';

class RegisterUseCase implements UseCase<DataState<UserCredential>, RegisterParams> {
  final AuthRepository authRepository;

  RegisterUseCase(this.authRepository);

  @override
  Future<DataState<UserCredential>> call({RegisterParams? params}) {
    return authRepository.register(
      params!.name,
      params.gender,
      params.email,
      params.phoneNumber,
      params.password,
    );
  }
}

class RegisterParams {
  final String name;
  final String gender;
  final String email;
  final String phoneNumber;
  final String password;
  final String confirmPassword;

  RegisterParams({
    required this.name,
    required this.gender,
    required this.email,
    required this.phoneNumber,
    required this.password,
    required this.confirmPassword,
  });
}
