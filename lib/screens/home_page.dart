
import 'package:flutter/material.dart';

import '../auth/auth_service.dart';
import '../services/chat/chat_service.dart';
import '../utils/functions.dart';
import '../widgets/my_drawer.dart';
import '../widgets/user_tile.dart';
import 'chat_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  //chat & auth service
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Chats"),
        actions: [
          IconButton(
            onPressed: () => logout(context),
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      drawer: const MyDrawer(),
      body: _buildUserList(), // Přidáno zobrazení seznamu uživatelů
    );
  }

  //list uživatelů(kontaktů) pro zrovna přihlášeného uživatele
  Widget _buildUserList() {
    return StreamBuilder(
      stream: _chatService.getUsersStream(),
      builder: (context, snapshot) {
        //error
        if (snapshot.hasError) {
          return const Text("Error");
        }

        //loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading...");
        }

        //vrácení ListView
        return ListView(
          children: snapshot.data!
              .map<Widget>((userData) => _buildUserListItem(userData, context))
              .toList(),
        );
      },
    );
  }

  Widget _buildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
    if (userData["email"] != _authService.getCurrentUser()!.email) {
      return UserTile(
        text: userData["fullName"],
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) =>  ChatPage(receiverEmail: userData["email"],receiverID: userData["uid"],)));
        },
      );
    } else {
      return Container();
    }
  }
}
