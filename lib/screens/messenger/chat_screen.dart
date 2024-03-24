import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {

  static const String screenTitle = 'Chat';

  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: const Center(child: Text(screenTitle)),
      ),
      body: const Center(child: Text(screenTitle)),
    );
  }
}