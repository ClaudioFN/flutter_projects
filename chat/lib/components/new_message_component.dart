import 'package:chat/core/services/auth/auth_service.dart';
import 'package:chat/core/services/chat/chat_service.dart';
import 'package:flutter/material.dart';

class NewMessageComponent extends StatefulWidget {
  const NewMessageComponent({super.key});

  @override
  State<NewMessageComponent> createState() => _NewMessageComponentState();
}

class _NewMessageComponentState extends State<NewMessageComponent> {

  String _enteredMenssage = '';
  final _messageController = TextEditingController();

  Future<void> _sendMessage() async{
    
    final user = AuthService().currentUser;

    if (user != null) {
      final msg = await ChatService().save(_enteredMenssage, user);
      print(msg?.id);
      _messageController.clear();
    }
    

  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _messageController,
            onChanged: (msg) => setState(() {
              _enteredMenssage = msg;
            }),
            decoration: InputDecoration(
              labelText: 'Enviar Mensagem',
            ),
            onSubmitted: (_) {
              if (_enteredMenssage.trim().isNotEmpty) {
                _sendMessage();
              }
            },
          ),
        ),
        IconButton(
          icon: Icon(Icons.send),
          onPressed: _enteredMenssage.trim().isEmpty ? null : _sendMessage,
        ),
      ],
    );
  }
}
