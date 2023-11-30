import 'package:nhagiare_mobile/core/resources/data_state.dart';
import 'package:nhagiare_mobile/core/usecases/usecase.dart';
import 'package:nhagiare_mobile/features/domain/repository/authentication_repository.dart';
import 'package:nhagiare_mobile/features/domain/repository/conversation_repository.dart';

class SignOutUseCase implements UseCase<DataState<void>, void> {
  final AuthenticationRepository _authenRepository;
  final ConversationRepository _conversationRepository;
  SignOutUseCase(this._authenRepository, this._conversationRepository);

  @override
  Future<DataState<void>> call({void params}) {
    _conversationRepository.disconnect();
    return _authenRepository.signOut();
  }
}
