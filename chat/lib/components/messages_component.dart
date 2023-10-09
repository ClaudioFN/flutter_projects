import 'package:chat/components/message_bubble_component.dart';
import 'package:chat/core/models/chat_messages_model.dart';
import 'package:chat/core/services/auth/auth_service.dart';
import 'package:chat/core/services/chat/chat_service.dart';
import 'package:flutter/material.dart';

class MessagesComponent extends StatelessWidget {
  const MessagesComponent({super.key});

  @override
  Widget build(BuildContext context) {

    final currentUser = AuthService().currentUser;

    return StreamBuilder<List<ChatMessageModel>>(
      stream: ChatService().messagesStream(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: Text('Sem Mensagens. Vamos teclar?'),
          );
        } else {
          final msgs = snapshot.data!;
          return ListView.builder(
            reverse: true,
            itemCount: msgs.length,
            itemBuilder: (ctx, i) => MessageBubbleComponent(
              key: ValueKey(msgs[i].id),
              message: msgs[i],
              belongsToCurrentUser: currentUser?.id == msgs[i].userId,
            ),
          );
        }
      },
    );
  }
}
