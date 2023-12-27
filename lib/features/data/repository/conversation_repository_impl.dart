import 'dart:io';

import 'package:dio/dio.dart';
import 'package:nhagiare_mobile/core/resources/data_state.dart';
import 'package:nhagiare_mobile/features/data/data_sources/local/authentication_local_data_source.dart';
import 'package:nhagiare_mobile/features/data/data_sources/remote/conversation_remote_data_source.dart';
import 'package:nhagiare_mobile/features/data/models/chat/conversation_model.dart';
import 'package:nhagiare_mobile/features/data/models/chat/message_model.dart';
import 'package:nhagiare_mobile/features/domain/repository/conversation_repository.dart';
import 'package:nhagiare_mobile/features/domain/repository/media_repository.dart';

import '../../domain/enums/conversation_enums.dart';
import '../../domain/enums/message_types.dart';

class ConversationRepositoryImpl extends ConversationRepository {
  final ConversationRemoteDataSource _conversationRemoteDataSource;
  final AuthenLocalDataSrc _authenLocalDataSrc;
  final MediaRepository _mediaRepository;
  ConversationRepositoryImpl(this._conversationRemoteDataSource,
      this._authenLocalDataSrc, this._mediaRepository);

  @override
  void addConversationListener(Function(List<ConversationModel> p1) listener) {
    _conversationRemoteDataSource.addConversationListener(listener);
  }

  @override
  List<ConversationModel> getConversations() {
    return _conversationRemoteDataSource.getConversations();
  }

  @override
  void removeConversationListener(
      Function(List<ConversationModel> p1) listener) {
    _conversationRemoteDataSource.removeConversationListener(listener);
  }

  @override
  void addMessageListener(
      String conversationId, Function(List<MessageModel> p1) listener) {
    _conversationRemoteDataSource.addMessageListener(conversationId, listener);
  }

  @override
  List<MessageModel>? initChat({String? conversationId, String? userId}) {
    return _conversationRemoteDataSource.initChat(
        userId: userId, conversationId: conversationId);
  }

  @override
  void removeMessageListener(
      String conversationId, Function(List<MessageModel> p1) listener) {
    _conversationRemoteDataSource.removeMessageListener(
        conversationId, listener);
  }

  @override
  void sendMessage(String conversationId, MessageTypes type, dynamic content) {
    _conversationRemoteDataSource.sendMessage(conversationId, type, content);
  }

  @override
  void connect() {
    final token = _authenLocalDataSrc.getAccessToken();
    _conversationRemoteDataSource.setAuthToken(token!);
    _conversationRemoteDataSource.connect();
  }

  @override
  void disconnect() {
    _conversationRemoteDataSource.disconnect();
  }

  @override
  void deleteConversation(String conversationId) {
    _conversationRemoteDataSource.deleteConversation(conversationId);
  }

  @override
  Future<DataState<ConversationModel>> getOrCreateConversation(
      String userId) async {
    try {
      final httpResponse =
          await _conversationRemoteDataSource.getOrCreateConversation(userId);
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(DioException(
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          type: DioExceptionType.badResponse,
          requestOptions: httpResponse.response.requestOptions,
        ));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<void> sendMediaMessage(String conversationId, List<File> media) async {
    DataState urls = await _mediaRepository.uploadMedia(media);
    if (urls is DataSuccess) {
      _conversationRemoteDataSource.sendMessage(
          conversationId, MessageTypes.media, urls.data);
    }
  }

  @override
  void sendTextMessage(String conversationId, String content) {
    _conversationRemoteDataSource.sendMessage(
        conversationId, MessageTypes.text, content);
  }
}
