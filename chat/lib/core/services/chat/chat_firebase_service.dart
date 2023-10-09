import 'dart:async';

import 'package:chat/core/models/chat_messages_model.dart';
import 'package:chat/core/models/chat_user_model.dart';
import 'package:chat/core/services/chat/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatFirebaseService implements ChatService {
  Stream<List<ChatMessageModel>> messagesStream() {
    final store = FirebaseFirestore.instance;
    final snapshots = store
        .collection('chat')
        .withConverter(fromFirestore: _fromFirestore, toFirestore: _toFirestore)
        .orderBy('createdAt', descending: true)
        .snapshots();

    
    return snapshots.map((snapshot) {
      return snapshot.docs.map((e) {
        return e.data();
      }).toList();
    });
    // Segunda forma de uso para a exibicao das mensagens
    // return Stream<List<ChatMessageModel>>.multi((controller) {
    //   snapshots.listen((query) {
    //     List<ChatMessageModel> lista = query.docs.map((doc){
    //       return doc.data();
    //     }).toList();
    //     controller.add(lista);
    //   });
    // });
  }

  @override
  Future<ChatMessageModel?> save(String text, ChatUser user) async {
    final store = FirebaseFirestore.instance;
    final msg = ChatMessageModel(
      id: '',
      text: text,
      createdAt: DateTime.now(),
      userId: user.id,
      userName: user.name,
      userImageURL: user.imageURL,
    );

    // ChatMessage => Map<String, dynamic>
    final docRef = await store
        .collection('chat')
        .withConverter(
          fromFirestore: _fromFirestore,
          toFirestore: _toFirestore,
        )
        .add(msg);

    final doc = await docRef.get();
    return doc.data()!;
    // Map<String, dynamic> => ChatMessage

    //return ChatMessageModel(
    //  id: doc.id,
    //  text: data['text'],
    //  createdAt: DateTime.parse(data['createdAt']),
    //  userId: data['userId'],
    //  userName: data['userName'],
    //  userImageURL: data['userImageURL'],
    //);
  }

  //         .withConverter(fromFirestore: fromFirestore, toFirestore: toFirestore)

  // ChatMessage => Map<String, dynamic>
  Map<String, dynamic> _toFirestore(ChatMessageModel msg, SetOptions? options) {
    return {
      'text': msg.text,
      'createdAt': msg.createdAt.toIso8601String(),
      'userId': msg.userId,
      'userName': msg.userName,
      'userImageURL': msg.userImageURL,
    };
  }

  // Map<String, dynamic> => ChatMessage
  ChatMessageModel _fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
    SnapshotOptions? options,
  ) {
    return ChatMessageModel(
      id: doc.id,
      text: doc['text'],
      createdAt: DateTime.parse(doc['createdAt']),
      userId: doc['userId'],
      userName: doc['userName'],
      userImageURL: doc['userImageURL'],
    );
  }
}
