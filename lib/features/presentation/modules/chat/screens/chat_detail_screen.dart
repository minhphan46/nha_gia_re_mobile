import 'package:flutter/material.dart';
import 'package:nhagiare_mobile/features/presentation/global_widgets/my_appbar.dart';
import '../chat_controler.dart';

class ChatDetailScreen extends StatelessWidget {
  ChatDetailScreen({super.key});

  final ChatController controller = ChatController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppbar(title: "Chi tiết tin nhắn"),
      body: const Center(
        child: Text('Chat Detail Screen'),
      ),
    );
  }
}
