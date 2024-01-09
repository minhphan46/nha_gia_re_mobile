import 'package:nhagiare_mobile/core/resources/data_state.dart';

import '../../../../core/usecases/usecase.dart';
import '../../repository/user_repository.dart';

class CheckUserFollowUseCase extends UseCase<DataState<bool>, String> {
  final UserRepository _userRepository;

  CheckUserFollowUseCase(this._userRepository);

  @override
  Future<DataState<bool>> call({String? params}) {
    return _userRepository.checkFollowUser(params!);
  }
}
