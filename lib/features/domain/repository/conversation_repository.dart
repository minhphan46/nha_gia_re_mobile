import 'dart:io';
import 'package:nhagiare_mobile/core/resources/data_state.dart';
import 'package:nhagiare_mobile/features/data/models/chat/conversation_model.dart';
import 'package:nhagiare_mobile/features/data/models/chat/message_model.dart';
import 'package:nhagiare_mobile/features/domain/enums/message_types.dart';

abstract class ConversationRepository {
  void addConversationListener(Function(List<ConversationModel>) listener);
  void removeConversationListener(Function(List<ConversationModel>) listener);
  List<ConversationModel> getConversations();
  void addMessageListener(
      String conversationId, Function(List<MessageModel>) listener);
  void removeMessageListener(
      String conversationId, Function(List<MessageModel>) listener);
  List<MessageModel>? initChat({String? conversationId, String? userId});
  void sendTextMessage(String conversationId, String content);
  void connect();
  void disconnect();
  void deleteConversation(String conversationId);
  Future<DataState<ConversationModel>> getOrCreateConversation(String userId);
  void sendMediaMessage(String conversationId, List<File> media);
  void sendMessage(String conversationId, MessageTypes type, dynamic content);
}
