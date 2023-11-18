import 'package:flutter/material.dart';
import 'package:nhagiare_mobile/features/presentation/global_widgets/my_appbar.dart';
import '../chat_controler.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});

  final ChatController controller = ChatController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppbar(title: "Tin nhắn"),
      body: const Center(
        child: Text('Chatting Screen'),
      ),
    );
  }
}
