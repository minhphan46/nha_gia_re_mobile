import 'package:equatable/equatable.dart';
import 'package:nhagiare_mobile/features/domain/entities/chat/message.dart';
import 'package:nhagiare_mobile/features/domain/entities/chat/participant.dart';
import 'package:nhagiare_mobile/features/domain/entities/user/user.dart';

// ignore: must_be_immutable
class Conversation extends Equatable {
  final String id;
  final DateTime createdAt;
  final String? lastMessageId;
  final bool? isRead;
  final Message? lastMessage;
  final List<Participant>? participants;
  late List<Message>? messages;
  final List<UserEntity>? users;

  Conversation({
    required this.id,
    required this.createdAt,
    required this.lastMessageId,
    required this.isRead,
    required this.lastMessage,
    required this.participants,
    required this.messages,
    required this.users,
  });

  @override
  List<Object?> get props => [
        id,
        createdAt,
        lastMessageId,
        isRead,
        lastMessage,
        participants,
        messages,
        users,
      ];
}
