import 'package:chat/core/models/chat_messages_model.dart';
import 'package:chat/core/models/chat_user_model.dart';
import 'package:chat/core/services/chat/chat_firebase_service.dart';

abstract class ChatService {

  Stream<List<ChatMessageModel>> messagesStream();
  Future<ChatMessageModel?> save(String text, ChatUser user);

  factory ChatService() {
    return ChatFirebaseService();
  }

}