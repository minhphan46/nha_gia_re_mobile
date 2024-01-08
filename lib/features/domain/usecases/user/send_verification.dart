import 'package:nhagiare_mobile/core/resources/data_state.dart';
import 'package:nhagiare_mobile/core/usecases/usecase.dart';
import 'package:nhagiare_mobile/features/domain/entities/user/account_verification_requests.dart';
import 'package:nhagiare_mobile/features/domain/repository/user_repository.dart';

class SendVerificationUseCase
    implements UseCase<DataState<void>, AccountVerificationRequestEntity> {
  final UserRepository _postRepository;

  SendVerificationUseCase(this._postRepository);

  @override
  Future<DataState<void>> call({AccountVerificationRequestEntity? params}) {
    return _postRepository.sendVerificationUser(params!);
  }
}
