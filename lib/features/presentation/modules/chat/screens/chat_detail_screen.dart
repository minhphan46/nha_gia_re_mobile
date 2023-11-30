import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';
import 'package:nhagiare_mobile/config/theme/app_color.dart';
import 'package:nhagiare_mobile/config/theme/text_styles.dart';
import 'package:nhagiare_mobile/core/extensions/textstyle_ex.dart';
import 'package:nhagiare_mobile/features/data/models/chat/message_model.dart';
import 'package:nhagiare_mobile/features/domain/entities/chat/conversation.dart';
import 'package:nhagiare_mobile/features/domain/entities/chat/message.dart';
import 'package:nhagiare_mobile/features/domain/entities/user/user.dart';
import 'package:nhagiare_mobile/features/presentation/global_widgets/my_appbar.dart';
import 'package:nhagiare_mobile/features/presentation/modules/chat/chat_controler.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatDetailScreen extends StatefulWidget {
  const ChatDetailScreen({super.key});

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  late final Conversation conversation;
  late final FocusNode _focusNode;
  late final TextEditingController _textEditingController;
  RxBool isShowButtons = true.obs;
  ChatController controller = ChatController();
  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      _updateShowButtons();
    });
    _textEditingController = TextEditingController();
    final data = Get.arguments;
    if (data is UserEntity) {
      controller.initMessage(userId: data.id);
    } else if (data is Conversation) {
      controller.initMessage(conversationId: data.id);
    } else {
      Get.back();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
    _textEditingController.dispose();
    controller.disposeMessage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppbar(
        title: 'Nguyễn Nhật Hào', // Replace with the participant's name
      ),
      body: StreamBuilder<List<MessageModel>>(
          stream: controller.messages,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            List<MessageModel> messages = snapshot.data!;
            String userId = controller.getUserId()!;

// Bước 1: Sắp xếp tin nhắn theo thời gian
            messages.sort((a, b) => a.sentAt.compareTo(b.sentAt));

// Bước 2 và 3: Nhóm tin nhắn theo ngày
            Map<String, List<Message>> groupedMessages = {};
            for (Message message in messages) {
              DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(
                  message.sentAt.millisecondsSinceEpoch);
              String dateKey =
                  '${dateTime.year}-${dateTime.month}-${dateTime.day}';
              if (!groupedMessages.containsKey(dateKey)) {
                groupedMessages[dateKey] = [];
              }
              groupedMessages[dateKey]!.add(message);
            }

            final List<String> keys = groupedMessages.keys.toList();
            keys.sort((a, b) => b.compareTo(a));
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: keys.length,
                    reverse: true,
                    itemBuilder: (context, index) {
                      String dateKey = keys[index];
                      List<Message> messagesOfDay = groupedMessages[dateKey]!;

                      // Hiển thị ngày
                      Widget dateWidget = Center(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 8),
                          decoration: BoxDecoration(
                            color: AppColors
                                .grey200, // Màu nền của phần tiêu đề ngày
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Text(
                            dateKey,
                            style: AppTextStyles.regular14,
                          ),
                        ),
                      );

                      // Hiển thị các tin nhắn trong ngày
                      List<Widget> messageWidgets =
                          messagesOfDay.map((message) {
                        bool isMe = message.senderId == userId;
                        return Row(
                          mainAxisAlignment: isMe
                              ? MainAxisAlignment.end
                              : MainAxisAlignment.start,
                          children: [
                            Container(
                              constraints: BoxConstraints(
                                maxWidth:
                                    MediaQuery.of(context).size.width * 0.7,
                              ),
                              margin: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: isMe
                                    ? AppColors.green800
                                    : AppColors.grey100,
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: _buildTextMessage(
                                  message.content["text"], isMe),
                            ),
                          ],
                        );
                      }).toList();

                      return Column(
                        children: [dateWidget, ...messageWidgets],
                      );
                    },
                  ),
                ),
                _buildMessageInput(),
              ],
            );
          }),
    );
  }

  Widget _buildTextMessage(String message, bool isMe) {
    List<InlineSpan> textSpans = [];
    List<String> words = [];
    for (var i = 0; i < message.length; i++) {
      if (message[i] == ' ' || message[i] == '\n') {
        words.add(message[i]);
      } else {
        if (words.isEmpty) {
          words.add(message[i]);
        } else {
          words[words.length - 1] += message[i];
        }
      }
    }
    for (String word in words) {
      if (isURL(word)) {
        // Nếu là đường dẫn, thêm một phần tử GestureDetector để mở trình duyệt khi nhấn vào
        textSpans.add(
          TextSpan(
            text: '$word ',
            style: AppTextStyles.regular16
                .colorEx(
                  isMe ? AppColors.white : AppColors.black,
                )!
                .copyWith(
                  decoration: TextDecoration.underline,
                )
                .copyWith(
                  fontWeight: FontWeight.w500,
                ),
            recognizer: TapGestureRecognizer()..onTap = () => launchURL(word),
          ),
        );
      } else {
        // Nếu không phải đường dẫn, thêm văn bản bình thường
        textSpans.add(TextSpan(
            text: '$word ',
            style: AppTextStyles.regular16
                .colorEx(isMe ? AppColors.white : AppColors.black)!));
      }
    }

    return RichText(
      text: TextSpan(
        children: textSpans,
      ),
    );
  }

  bool isURL(String word) {
    // Kiểm tra xem một chuỗi có phải là một đường dẫn không
    Uri? uri = Uri.tryParse(word.trim());
    return uri != null && (uri.scheme == 'http' || uri.scheme == 'https');
  }

  void launchURL(String url) async {
    // Mở trình duyệt với đường dẫn đã cho
    Uri uri = Uri.parse(url.trim());
    await canLaunchUrl(uri)
        ? await launchUrl(uri)
        : Get.snackbar('Could not launch this url', '');
  }

  bool _updateShowButtons() {
    bool val = !_focusNode.hasFocus || _textEditingController.text.isEmpty;
    if (isShowButtons.value != val) {
      isShowButtons.value = val;
    }
    return val;
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Obx(
        () => Row(
          children: [
            Visibility(
              visible: isShowButtons.value,
              child: IconButton(
                icon: const Icon(
                  HeroiconsSolid.photo,
                  color: AppColors.green,
                ),
                onPressed: () {
                  // Implement the logic to handle image
                },
              ),
            ),
            Expanded(
              child: TextField(
                maxLines: 6,
                minLines: 1,
                controller: _textEditingController,
                onChanged: (value) {
                  _updateShowButtons();
                },
                focusNode: _focusNode,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  border: OutlineInputBorder(
                    gapPadding: 0,
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                  hintText: 'Tin nhắn',
                ),
              ),
            ),
            IconButton(
              icon: const Icon(
                HeroiconsSolid.paperAirplane,
                color: AppColors.green,
              ),
              onPressed: () {
                if (_textEditingController.text.trim().isEmpty) return;
                controller
                    .sendMessage(_textEditingController.text.trim().toString());
                _textEditingController.clear();
              },
            ),
          ],
        ),
      ),
    );
  }
}
