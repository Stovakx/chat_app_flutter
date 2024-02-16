import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;

  const ChatBubble({
    Key? key,
    required this.message,
    required this.isCurrentUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double maxWidth = MediaQuery.of(context).size.width * 0.6; 
        if (constraints.maxWidth < maxWidth) {
          maxWidth = constraints.maxWidth; 
        }

        return Container(
          decoration: BoxDecoration(
            color: isCurrentUser ? Colors.green : Colors.grey.shade500,
            borderRadius: BorderRadius.circular(10),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 3),
          constraints: BoxConstraints(
            maxWidth: maxWidth,
          ),
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  message,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}