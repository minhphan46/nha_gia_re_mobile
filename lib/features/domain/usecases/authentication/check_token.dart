import 'package:nhagiare_mobile/core/resources/data_state.dart';
import 'package:nhagiare_mobile/core/usecases/usecase.dart';
import 'package:nhagiare_mobile/features/domain/repository/authentication_repository.dart';

class CheckTokenUseCase implements UseCase<DataState<bool>, void> {
  final AuthenticationRepository _authenRepository;

  CheckTokenUseCase(this._authenRepository);

  @override
  Future<DataState<bool>> call({void params}) async {
    final result = await _authenRepository.refreshNewAccessToken();
    if (result is DataSuccess) {
      return const DataSuccess(true);
    }
    return const DataSuccess(false);
  }
}
