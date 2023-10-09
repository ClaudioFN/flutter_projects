import 'package:chat/core/models/chat_notification_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class ChatNotificationService with ChangeNotifier {
  List<ChatNotification> _items = [];

  int get itemsCount {
    return _items.length;
  }

  List<ChatNotification> get items {
    return [..._items];
  }

  void add(ChatNotification notification) {
    _items.add(notification);
    notifyListeners();
  }

  void remove(int i) {
    _items.removeAt(i);
    notifyListeners();
  }

  // Para tratar das Push Notification
  Future<void> init() async {

    await _configureTerminated();
    await _configureForeground();
    await _configureBackground();
    
  }

  Future<bool> get _isAuthorized async {
    final messaging = FirebaseMessaging.instance;
    final settings = await messaging.requestPermission();

    return settings.authorizationStatus == AuthorizationStatus.authorized;
  }

  Future<void> _configureForeground() async {
    if (await _isAuthorized) {
      FirebaseMessaging.onMessage.listen(_messageHandler);
    }
  }

  Future<void> _configureBackground() async {
    if (await _isAuthorized) {
      FirebaseMessaging.onMessageOpenedApp.listen(_messageHandler);
    }
  }

  Future<void> _configureTerminated() async {
    if (await _isAuthorized) {
      RemoteMessage? initialMsg = await FirebaseMessaging.instance.getInitialMessage();
      _messageHandler(initialMsg);
    }
  }  

  void _messageHandler(RemoteMessage? event) {
    if (event == null || event.notification == null) return;

    add(
      ChatNotification(
        title: event.notification!.title ?? 'Não Informado!',
        body: event.notification!.body ?? 'Não Informado!',
      ),
    );
  }
}
