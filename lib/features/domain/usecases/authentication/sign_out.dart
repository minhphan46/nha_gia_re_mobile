import 'package:nhagiare_mobile/core/resources/data_state.dart';
import 'package:nhagiare_mobile/core/usecases/usecase.dart';
import 'package:nhagiare_mobile/features/domain/repository/authentication_repository.dart';
import 'package:nhagiare_mobile/features/domain/repository/conversation_repository.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class SignOutUseCase implements UseCase<DataState<void>, void> {
  final AuthenticationRepository _authenRepository;
  final ConversationRepository _conversationRepository;
  SignOutUseCase(this._authenRepository, this._conversationRepository);

  @override
  Future<DataState<void>> call({void params}) {
    _conversationRepository.disconnect();

    final userId = _authenRepository.getUserId();
    OneSignal.logout().then((value) => print("Logout Success"));

    return _authenRepository.signOut();
  }
}
