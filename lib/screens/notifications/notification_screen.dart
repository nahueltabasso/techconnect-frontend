import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {

  static const String screenTitle = 'Notificaciones';

  const NotificationScreen({super.key});

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