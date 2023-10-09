import 'dart:io';

import 'package:chat/core/models/chat_user_model.dart';
import 'package:chat/core/services/auth/auth_firebase_service.dart';

abstract class AuthService {
  ChatUser? get currentUser;
  Stream<ChatUser?> get userChanges;

  Future<void> signup(
    String name,
    String email,
    String password,
    File? image,
  );

  Future<void> login(
    String email,
    String password,
  );

  Future<void> logout();

  // Construtor factory - retornar uma subclasse que permite retornar as implementacoes ao inves da classe mae
  factory AuthService() {
    //return AuthMockService();
    return AuthFirebaseService();
  }

  
}
