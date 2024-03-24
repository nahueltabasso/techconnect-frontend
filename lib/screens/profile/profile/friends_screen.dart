import 'package:flutter/material.dart';

class FriendsScreen extends StatelessWidget {
  
  static const String screenTitle = 'Mis Amigos';

  const FriendsScreen({super.key});

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