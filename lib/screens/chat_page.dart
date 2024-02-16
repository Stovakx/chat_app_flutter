

import 'package:flutter/material.dart';

import '../auth/auth_service.dart';
import '../services/chat/chat_service.dart';

class ChatPage extends StatelessWidget {
  final String receiverEmail;
  final String receiverID;

  //text controller
  final TextEditingController _messageController = TextEditingController();

  //chat & auth services
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  //odslání zprávy
  void sendMessage() async{
    //pokud textový pole není prázdné
    if (_messageController.text.isNotEmpty){
      await _chatService.sendMessage(receiverID, _messageController.text);

      //clear input
      _messageController.clear();
    }
    
  }

  ChatPage(
      {super.key, required this.receiverEmail, required this.receiverID});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(receiverEmail),
        centerTitle: true,
      ),
      body: const Center(
        child: Text("chat"),
      ),
    );
  }
}
