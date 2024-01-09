import 'package:nhagiare_mobile/core/resources/data_state.dart';
import 'package:nhagiare_mobile/core/usecases/usecase.dart';
import 'package:nhagiare_mobile/features/domain/repository/authentication_repository.dart';
import 'package:nhagiare_mobile/features/domain/repository/conversation_repository.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class CheckTokenUseCase implements UseCase<DataState<bool>, void> {
  final AuthenticationRepository _authenRepository;

  final ConversationRepository _conversationRepository;
  CheckTokenUseCase(this._authenRepository, this._conversationRepository);

  @override
  Future<DataState<bool>> call({void params}) async {
    final result = await _authenRepository.refreshNewAccessToken();
    if (result is DataSuccess) {
      _conversationRepository.connect();
      return const DataSuccess(true);
    }
    final userId = _authenRepository.getUserId();
    if (userId is DataSuccess) {
      OneSignal.login(userId.data!)
          .then((value) => print("Login Success"))
          .catchError((error) => print("Login Error: $error"));
    }

    return const DataSuccess(false);
  }
}
