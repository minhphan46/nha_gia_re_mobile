import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nhagiare_mobile/core/resources/data_state.dart';
import 'package:nhagiare_mobile/features/data/models/chat/conversation_model.dart';
import 'package:nhagiare_mobile/features/data/models/chat/message_model.dart';
import 'package:nhagiare_mobile/features/domain/repository/authentication_repository.dart';
import 'package:nhagiare_mobile/features/domain/repository/conversation_repository.dart';
import 'package:nhagiare_mobile/features/domain/repository/media_repository.dart';
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

  String conversationId = '';
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

  void initMessage({String? conversationId, String? userId}) {
    if (conversationId != null) {
      this.conversationId = conversationId;
      List<MessageModel>? messages = _conversationRepository.initChat(
          conversationId: conversationId, userId: userId);
      _conversationRepository.addMessageListener(
          conversationId, listenerMessage);
      if (messages != null) {
        _messagesStreamController.sink.add(messages);
      }
    } else if (userId != null) {
      _conversationRepository.getOrCreateConversation(userId).then((value) {
        if (value is DataSuccess) {
          final data = value.data!;
          _conversationRepository.addMessageListener(data.id, listenerMessage);
          this.conversationId = value.data!.id;
          List<MessageModel>? messages = _conversationRepository.initChat(
              conversationId: this.conversationId);
          if (messages != null) {
            _messagesStreamController.sink.add(messages);
          }
        } else if (value is DataFailed) {
          Get.back();
        }
      });
    }
  }

  void disposeMessage() {
    if (conversationId.isNotEmpty) {
      _conversationRepository.removeMessageListener(
          conversationId, listenerMessage);
    }
  }

  void sendMessage(String message) {
    print("Send message...");
    if (mediaPicker.isNotEmpty) {
      _conversationRepository.sendMediaMessage(conversationId, mediaPicker);
    } else if (message.isNotEmpty) {
      _conversationRepository.sendTextMessage(conversationId, message);
    }
  }

  void deleteConversation(String conversationId) {
    _conversationRepository.deleteConversation(conversationId);
  }

  @override
  void onClose() {
    _conversationsStreamController.close();
    _messagesStreamController.close();
    super.onClose();
  }

  RxList<File> mediaPicker = RxList<File>();
  Future<void> pickMedias() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.media,
    );
    if (result != null) {
      mediaPicker.addAll(result.files.map((e) => File(e.path!)).toList());
    }
  }

  Future<void> takeAPhoto() async {
    final imagePicker = ImagePicker();
    XFile? xFile = await imagePicker.pickImage(source: ImageSource.camera);
    if (xFile != null) {
      mediaPicker.add(File(xFile.path));
    }
  }

  void removeMedia(File file) {
    mediaPicker.remove(file);
    update();
  }
}
