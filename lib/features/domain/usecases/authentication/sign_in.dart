import 'package:nhagiare_mobile/core/resources/data_state.dart';
import 'package:nhagiare_mobile/core/usecases/usecase.dart';
import 'package:nhagiare_mobile/features/domain/repository/authentication_repository.dart';

class SignInUseCase implements UseCase<DataState<void>, Map<String, dynamic>?> {
  final AuthenticationRepository _authenRepository;

  SignInUseCase(this._authenRepository);

  @override
  Future<DataState<void>> call({Map<String, dynamic>? params}) {
    return _authenRepository.signIn(params!['email'], params['password']);
  }
}
