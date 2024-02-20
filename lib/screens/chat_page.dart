import 'package:chatapp/screens/personal_page.dart';
import 'package:chatapp/widgets/chat_bubble.dart';
import 'package:chatapp/widgets/my_textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../auth/auth_service.dart';
import '../services/chat/chat_service.dart';

class ChatPage extends StatefulWidget {
  final String receiverFullName;
  final String receiverID;

  const ChatPage(
      {super.key, required this.receiverFullName, required this.receiverID});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  //text controller
  final TextEditingController _messageController = TextEditingController();

  //chat & auth services
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();
  final ScrollController _scrollController = ScrollController();

  //textfield focus
  FocusNode myFocusNode = FocusNode();

  void scrollDown(){
    _scrollController.animateTo(_scrollController.position.maxScrollExtent , duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
  }

  @override
  void initState() {
    super.initState();
    //listener pro focusNode
    myFocusNode.addListener(() {
      if (myFocusNode.hasFocus) {
        //spoždění na klávesnici, výpočet zbývajícího místa, scroll down
        Future.delayed(
          const Duration(milliseconds: 500),
          () => scrollDown(),

        );
      }
    });
  }

  //odslání zprávy
  void sendMessage() async {
    //pokud textový pole není prázdné
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
          widget.receiverID, _messageController.text);

      //clear input
      _messageController.clear();
      scrollDown();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=> PersonalPage(id: widget.receiverID,)));},
          child: Text(widget.receiverFullName),
        ),
        centerTitle: true,
      ),
      body: Column(children: [
        Expanded(child: _buildMessageList()),
        _buildMessageInput()
      ]),
    );
  }

  //message list
  Widget _buildMessageList() {
    return StreamBuilder<QuerySnapshot>(
      stream: _chatService.getMessages(
        widget.receiverID,
        _authService.getCurrentUser()!.uid,
      ),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error ${snapshot.error.toString()}');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }
        return ListView(
          controller: _scrollController,
          cacheExtent: double.infinity,
          children: snapshot.data!.docs.map((document) {
            return _buildMessageItem(document);
          }).toList(),
        );
      },
    );
  }

  //message item
  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    bool isCurrentUser = data['senderID'] == _authService.getCurrentUser()!.uid;
    var alignemt = (data['senderID'] == _authService.getCurrentUser()!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;
    return Container(
      alignment: alignemt,
      child: ChatBubble(message: data["message"], isCurrentUser: isCurrentUser),
    );
  }

  //messageInput
  Widget _buildMessageInput() {
    return Row(
      children: [
        Expanded(
            child: MyTextfield(
          hintText: "Type a message",
          obscureText: false,
          controller: _messageController,
          borderRadius: 18,
          focusNode: myFocusNode,
        )),
        IconButton(
            onPressed: sendMessage,
            icon: const Icon(
              Icons.send,
              size: 30,
            ))
      ],
    );
  }
}
