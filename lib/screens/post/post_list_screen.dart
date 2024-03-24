import 'package:flutter/material.dart';

class PostListScreen extends StatelessWidget {

  static const String screenTitle = 'Inicio';

  const PostListScreen({super.key});

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