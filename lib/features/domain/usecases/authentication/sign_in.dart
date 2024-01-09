import 'package:nhagiare_mobile/core/resources/data_state.dart';
import 'package:nhagiare_mobile/core/usecases/usecase.dart';
import 'package:nhagiare_mobile/features/domain/repository/authentication_repository.dart';
import 'package:nhagiare_mobile/features/domain/repository/conversation_repository.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class SignInUseCase implements UseCase<DataState<void>, Map<String, dynamic>?> {
  final ConversationRepository _conversationRepository;
  final AuthenticationRepository _authenRepository;

  SignInUseCase(this._authenRepository, this._conversationRepository);

  @override
  Future<DataState<void>> call({Map<String, dynamic>? params}) async {
    final data =
        await _authenRepository.signIn(params!['email'], params['password']);
    if (data is DataSuccess) {
      _conversationRepository.connect();
    }
    final userId = _authenRepository.getUserId();
    if (userId is DataSuccess) {
      OneSignal.login(userId.data!)
          .then((value) => print("Login Success"))
          .catchError((error) => print("Login Error: $error"));
    }
    return data;
  }
}
