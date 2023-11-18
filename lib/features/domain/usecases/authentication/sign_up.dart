import 'package:nhagiare_mobile/core/resources/data_state.dart';
import 'package:nhagiare_mobile/core/usecases/usecase.dart';
import 'package:nhagiare_mobile/features/domain/repository/authentication_repository.dart';

class SignUpUseCase
    implements UseCase<DataState<String>, Map<String, dynamic>?> {
  final AuthenticationRepository _authenRepository;

  SignUpUseCase(this._authenRepository);

  @override
  Future<DataState<String>> call({Map<String, dynamic>? params}) {
    return _authenRepository.signUp(
        params!['email'], params['password'], params['confirmPassword']);
  }
}
