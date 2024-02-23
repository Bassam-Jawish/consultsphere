import 'package:consultsphere/core/resources/data_state.dart';
import 'package:consultsphere/core/usecases/usecase.dart';
import 'package:consultsphere/features/authentication/domain/repository/auth_repo.dart';

class ResetPasswordUseCase implements UseCase<DataState<void>, String> {
  final AuthRepository authRepository;

  ResetPasswordUseCase(this.authRepository);

  @override
  Future<DataState<void>> call({String? params}) {
    return authRepository.sendPasswordResetEmail(params!);
  }
}