import 'dart:async';

import 'package:get/get.dart';
import 'package:nhagiare_mobile/core/resources/data_state.dart';
import 'package:nhagiare_mobile/features/data/models/chat/conversation_model.dart';
import 'package:nhagiare_mobile/features/data/models/chat/message_model.dart';
import 'package:nhagiare_mobile/features/domain/repository/authentication_repository.dart';
import 'package:nhagiare_mobile/features/domain/repository/conversation_repository.dart';
import 'package:nhagiare_mobile/injection_container.dart';

class ChatController extends GetxController {
  final ConversationRepository _conversationRepository =
      sl.get<ConversationRepository>();
  final AuthenticationRepository _authenRepository =
      sl.get<AuthenticationRepository>();
  final StreamController<List<ConversationModel>>
      _conversationsStreamController =
      StreamController<List<ConversationModel>>();
  Stream<List<ConversationModel>> getConversations() {
    return _conversationsStreamController.stream;
  }

  late String conversationId;
  final StreamController<List<MessageModel>> _messagesStreamController =
      StreamController<List<MessageModel>>();

  Stream<List<MessageModel>> get messages => _messagesStreamController.stream;
  void listenerConversation(List<ConversationModel> data) {
    _conversationsStreamController.sink.add(data);
  }

  String? getUserId() {
    final result = _authenRepository.getUserId();
    if (result is DataSuccess) {
      return result.data!;
    }
    return null;
  }

  void initConversation() {
    _conversationsStreamController.sink
        .add(_conversationRepository.getConversations());
    _conversationRepository.addConversationListener(listenerConversation);
  }

  void disposeConversation() {
    _conversationRepository.removeConversationListener(listenerConversation);
  }

  void listenerMessage(List<MessageModel> data) {
    _messagesStreamController.sink.add(data);
  }

  void initMessage(String conversationId) {
    this.conversationId = conversationId;
    List<MessageModel>? messages =
        _conversationRepository.initChat(conversationId);
    if (messages != null) {
      _messagesStreamController.sink.add(messages);
    }
    _conversationRepository.addMessageListener(conversationId, listenerMessage);
  }

  void disposeMessage() {
    _conversationRepository.removeMessageListener(
        conversationId, listenerMessage);
  }

  void sendMessage(String message) {
    _conversationRepository.sendTextMessage(conversationId, message);
  }

  @override
  void onClose() {
    _conversationsStreamController.close();
    _messagesStreamController.close();
    super.onClose();
  }
}
