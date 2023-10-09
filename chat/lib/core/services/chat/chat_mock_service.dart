import 'dart:async';
import 'dart:math';

import 'package:chat/core/models/chat_messages_model.dart';
import 'package:chat/core/models/chat_user_model.dart';
import 'package:chat/core/services/chat/chat_service.dart';

class ChatMockService implements ChatService {
  static final List<ChatMessageModel> _msgs = [ ];
  
  static MultiStreamController<List<ChatMessageModel>>? _controller;
  static final _msgsStream = Stream<List<ChatMessageModel>>.multi((controller) {
    _controller = controller;
    controller.add(_msgs);
  });

  Stream<List<ChatMessageModel>> messagesStream() {
    return _msgsStream;
  }

  Future<ChatMessageModel> save(String text, ChatUser user) async {
    final newMessage = ChatMessageModel(
      id: Random().nextDouble().toString(),
      text: text,
      createdAt: DateTime.now(),
      userId: user.id,
      userName: user.name,
      userImageURL: user.imageURL,
    );

    _msgs.add(newMessage);

    _controller?.add(_msgs.reversed.toList());

    return newMessage;
  }
}
