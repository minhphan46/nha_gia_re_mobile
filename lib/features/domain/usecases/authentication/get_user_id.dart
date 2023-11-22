import 'package:nhagiare_mobile/core/resources/data_state.dart';
import 'package:nhagiare_mobile/core/usecases/usecase.dart';
import 'package:nhagiare_mobile/features/domain/repository/authentication_repository.dart';

class GetUserIdUseCase implements UseCase<String?, void> {
  final AuthenticationRepository _authenRepository;
  GetUserIdUseCase(this._authenRepository);

  @override
  Future<String?> call({void params}) async {
    final userId = await _authenRepository.getUserId();
    if (userId is DataSuccess) {
      return userId.data!;
    } else {
      return null;
    }
  }
}
