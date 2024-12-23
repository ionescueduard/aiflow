import 'package:flutter/material.dart';
import '../widgets/chat_view.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Optional: Add AppBar or other UI elements
      body: ChatView(),
    );
  }
}
