import 'dart:io';
import 'dart:typed_data';

import 'package:retrofit/dio.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:nhagiare_mobile/core/constants/constants.dart';
import 'package:nhagiare_mobile/features/data/models/chat/message_model.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:nhagiare_mobile/features/data/models/chat/conversation_model.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../domain/enums/message_types.dart';

abstract class ConversationRemoteDataSource {
  List<ConversationModel> getConversations();
  void addConversationListener(Function(List<ConversationModel>) listener);
  void removeConversationListener(Function(List<ConversationModel>) listener);
  void notifyConversationListeners();
  void addMessageListener(
      String conversationId, Function(List<MessageModel>) listener);
  void removeMessageListener(
      String conversationId, Function(List<MessageModel>) listener);
  void notifyMessageListeners(String conversationId);
  void notifyMessageListenersAll();
  List<MessageModel>? initChat({String? conversationId, String? userId});
  void sendMessage(String conversationId, MessageTypes type, dynamic content);
  void deleteConversation(String conversationId);
  void disconnect();
  void connect();
  void setAuthToken(String token);
  Future<HttpResponse<ConversationModel>> getOrCreateConversation(
      String userId);

  void sendMediaMessage(String conversationId, List<File> media);
}

class ConversationRemoteDataSourceImpl implements ConversationRemoteDataSource {
  late IO.Socket socket;
  final List<Function(List<ConversationModel>)> _conversationListener = [];
  final Map<String, List<Function(List<MessageModel>)>> _messageListener = {};
  final List<ConversationModel> _conversations = [];
  final Map<String, List<MessageModel>> _messages = {};
  late String authToken;
  final Dio client;

  ConversationRemoteDataSourceImpl(this.client) {
    socket = IO.io('$baseAppUrl/conversations', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false
    });
  }

  @override
  List<ConversationModel> getConversations() {
    return _conversations;
  }

  @override
  void addConversationListener(Function(List<ConversationModel>) listener) {
    _conversationListener.add(listener);
  }

  @override
  void removeConversationListener(Function(List<ConversationModel>) listener) {
    _conversationListener.remove(listener);
  }

  @override
  void disconnect() {
    _conversations.clear();
    _messages.clear();
    _messageListener.clear();
    _conversationListener.clear();
    socket.disconnect();
    socket.dispose();
    print("Disconnected");
  }

  @override
  void connect() {
    socket.auth = {"token": authToken};
    socket.onConnect((data) {
      print('Connected');
      print(data);
    });
    socket.on('conversations', (result) {
      String type = result["type"];
      if (type == "init") {
        List<dynamic> data = result["data"] ?? [];
        _conversations.clear();
        _conversations.addAll(
            (data).map((e) => ConversationModel.fromJson(e)).toList().reversed);
        for (var element in _conversationListener) {
          element(_conversations);
        }
      } else if (type == "new") {
        _conversations.insert(0, ConversationModel.fromJson(result["data"]));
      } else if (type == "update") {
        _conversations
            .removeWhere((element) => element.id == result["data"]["id"]);
        _conversations.add(ConversationModel.fromJson(result["data"]));
      } else if (type == "delete") {
        _conversations
            .removeWhere((element) => element.id == result["data"]["id"]);
        _messages[result["data"]["id"]]?.clear();
      }
      notifyConversationListeners();
    });
    socket.on('messages', (data) {
      String type = data["type"] as String;
      String conversationId = data["conversation_id"] as String;
      if (_messages[conversationId] == null) {
        _messages[conversationId] = [];
      }
      if (type == 'init') {
        List<dynamic> messages = data["data"] ?? [];
        _messages[conversationId] =
            messages.map((e) => MessageModel.fromJson(e)).toList();
      } else if (type == 'new') {
        MessageModel message = MessageModel.fromJson(data["data"]);

        _messages[conversationId]!.insert(0, message);
      } else if (type == 'update') {
        MessageModel message = MessageModel.fromJson(data["data"]);
        int index = _messages[conversationId]!
            .indexWhere((element) => element.id == message.id);
        _messages[conversationId]![index] = message;
      } else if (type == 'delete') {
        MessageModel message = MessageModel.fromJson(data["data"]);
        _messages[conversationId]!
            .removeWhere((element) => element.id == message.id);
      }
      notifyMessageListeners(conversationId);
    });
    socket.connect().onError((data) => print(data));
    print("Connecting");
  }

  @override
  void addMessageListener(
      String conversationId, Function(List<MessageModel> p1) listener) {
    if (_messageListener.containsKey(conversationId)) {
      _messageListener[conversationId]!.add(listener);
    } else {
      _messageListener[conversationId] = [listener];
    }
  }

  @override
  void removeMessageListener(
      String conversationId, Function(List<MessageModel> p1) listener) {
    if (_messageListener.containsKey(conversationId)) {
      _messageListener[conversationId]!.remove(listener);
    }
  }

  @override
  List<MessageModel>? initChat({String? conversationId, String? userId}) {
    assert(conversationId != null || userId != null);
    if (conversationId != null) {
      if (_messages.containsKey(conversationId)) {
        return _messages[conversationId];
      } else {
        socket.emit('init_chat', {
          "conversation_id": conversationId,
        });
        return null;
      }
    } else {
      for (var element in _conversations) {
        if (element.participants![0].userId == userId ||
            element.participants![1].userId == userId) {
          return _messages[element.id];
        }
      }
      socket.emit('init_chat', {
        "other_user_id": userId,
      });
      return null;
    }
  }

  @override
  void sendMessage(String conversationId, MessageTypes type, dynamic content) {
    switch (type) {
      case MessageTypes.text:
        assert(content is String);
        break;
      case MessageTypes.media:
        assert(content is List<String>);
        break;
      default:
    }
    socket.emit('send_message', {
      "conversation_id": conversationId,
      "type": type.toString().split(".").last,
      "content": content,
    });
  }

  @override
  void setAuthToken(String token) {
    authToken = token;
  }

  @override
  void notifyConversationListeners() {
    for (var element in _conversationListener) {
      element(_conversations);
    }
  }

  @override
  void notifyMessageListeners(String conversationId) {
    if (_messageListener.containsKey(conversationId)) {
      for (var element in _messageListener[conversationId]!) {
        element(_messages[conversationId]!);
      }
    }
  }

  @override
  void notifyMessageListenersAll() {
    _messageListener.forEach((key, value) {
      for (var element in value) {
        element(_messages[key]!);
      }
    });
  }

  @override
  void deleteConversation(String conversationId) {
    socket.emit('delete_conversation', {
      "conversation_id": conversationId,
    });
  }

  @override
  Future<HttpResponse<ConversationModel>> getOrCreateConversation(
      String userId) {
    String url = '$apiAppUrl$kGetOrCreateConversation';
    url = url.replaceAll(":id", userId);
    try {
      return client
          .get(url,
              data: {
                "other_user_id": userId,
              },
              options: Options(headers: {'Authorization': 'Bearer $authToken'}))
          .then((response) {
        if (response.statusCode != 200) {
          throw ApiException(
            message: response.data,
            statusCode: response.statusCode!,
          );
        }
        ConversationModel value =
            ConversationModel.fromJson(response.data["result"]);
        print("Conversation: $value");
        return HttpResponse(value, response);
      });
    } on ApiException {
      rethrow;
    } catch (error) {
      throw ApiException(message: error.toString(), statusCode: 505);
    }
  }

  @override
  void sendMediaMessage(String conversationId, List<File> media) {
    List<Future<Uint8List>> medias = [];
    for (var element in media) {
      medias.add(element.readAsBytes());
    }
    Future.wait(medias).then((value) {
      List<dynamic> data = [];
      media.asMap().forEach((index, element) {
        data.add({
          "file_name": element.path.split("/").last,
          "bytes": value[index],
        });
      });
      socket.emit('send_media_message', {
        "conversation_id": conversationId,
        "type": "media",
        "content": data,
      });
    });
  }
}
