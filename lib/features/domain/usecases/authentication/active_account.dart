import 'package:nhagiare_mobile/core/resources/data_state.dart';
import 'package:nhagiare_mobile/core/usecases/usecase.dart';
import 'package:nhagiare_mobile/features/domain/repository/authentication_repository.dart';

class CheckActiveTokenUseCase implements UseCaseSync<DataState<bool>, void> {
  final AuthenticationRepository _authenRepository;

  CheckActiveTokenUseCase(this._authenRepository);

  @override
  DataState<bool> call({void params}) {
    final data = _authenRepository.checkActiveToken();
    return data;
  }
}
