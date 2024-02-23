import 'package:consultsphere/core/resources/data_state.dart';
import 'package:consultsphere/core/usecases/usecase.dart';
import 'package:consultsphere/features/authentication/domain/repository/auth_repo.dart';

class SignOutUseCase implements UseCase<DataState<void>, NoParams> {
  final AuthRepository authRepository;

  SignOutUseCase(this.authRepository);

  @override
  Future<DataState<void>> call({NoParams? params}) {
    return authRepository.signOut();
  }
}