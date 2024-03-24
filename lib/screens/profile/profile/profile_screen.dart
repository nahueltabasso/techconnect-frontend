import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {

  static const String screenTitle = 'Mi Perfil';

  const ProfileScreen({super.key});

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