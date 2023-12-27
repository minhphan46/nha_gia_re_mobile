import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';
import 'package:nhagiare_mobile/config/theme/app_color.dart';
import 'package:nhagiare_mobile/config/theme/text_styles.dart';
import 'package:nhagiare_mobile/config/values/asset_image.dart';
import 'package:nhagiare_mobile/core/extensions/date_ex.dart';
import 'package:nhagiare_mobile/core/extensions/integer_ex.dart';
import 'package:nhagiare_mobile/features/domain/entities/chat/conversation.dart';
import 'package:nhagiare_mobile/features/domain/entities/user/user.dart';
import 'package:nhagiare_mobile/features/presentation/global_widgets/my_appbar.dart';
import 'package:nhagiare_mobile/features/presentation/modules/chat/screens/chat_detail_screen.dart';
import '../../../../domain/enums/message_types.dart';
import '../chat_controler.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key}) {
    controller.initConversation();
  }

  final ChatController controller = ChatController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppbar(
        title: "Tin nhắn",
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => const ChatDetailScreen(),
                  arguments: const UserEntity(
                      id: '28223664-4747-424e-b2e3-27ace26bc553'));
            },
            icon: const Icon(
              HeroiconsMini.user,
              color: AppColors.black,
            ),
          ),
        ],
      ),
      body: StreamBuilder<List<Conversation>>(
        stream: controller.getConversations(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final conversations = snapshot.data!;
            return conversations.isNotEmpty
                ? _buildConversationList(conversations)
                : _buildEmptyChatMessage();
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget _buildConversationList(List<Conversation> conversations) {
    return SingleChildScrollView(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: conversations.length,
        itemBuilder: (context, index) {
          Conversation conversation = conversations[index];

          // Check if the current item is not the last one to avoid adding divider after the last item
          bool isLastItem = index == conversations.length - 1;

          return Column(
            children: [
              ListTile(
                onLongPress: () {
                  Get.dialog(AlertDialog(
                    title: const Text('Xóa tin nhắn'),
                    content:
                        const Text('Bạn có chắc chắn muốn xóa tin nhắn này?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: const Text('Hủy'),
                      ),
                      TextButton(
                        onPressed: () {
                          controller.deleteConversation(conversation.id);
                          Get.back();
                        },
                        child: const Text('Xóa'),
                      ),
                    ],
                  ));
                },
                onTap: () {
                  Get.to(() => const ChatDetailScreen(),
                      arguments: conversation);
                },
                titleAlignment: ListTileTitleAlignment.threeLine,
                leading: const CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage(Assets.avatar2),
                ),
                title: Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    conversation.users![0].fullName,
                    style: AppTextStyles.semiBold16,
                  ),
                ),
                subtitle: Text(
                  conversation.lastMessage?.contentType == MessageTypes.text
                      ? conversation.lastMessage?.content['text'] ?? ''
                      : 'Đã gửi một hình ảnh',
                  style: conversation.isRead ?? true
                      ? AppTextStyles.semiBold14
                      : AppTextStyles.regular14,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: Text(
                  conversation.lastMessage?.sentAt.getTimeAgo() ??
                      DateTime.now().getTimeAgo(),
                  style: AppTextStyles.regular14,
                ),
              ),
              if (!isLastItem)
                const Divider(
                  color: AppColors.grey100,
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildEmptyChatMessage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.only(
              bottom: 16,
            ),
            width: 65.wp,
            child: Image.asset(Assets.emptyChat),
          ),
          Text(
            'Chưa có tin nhắn nào',
            style: AppTextStyles.regular16,
          )
        ],
      ),
    );
  }
}
