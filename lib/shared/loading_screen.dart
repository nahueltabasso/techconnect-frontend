import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {

  final String titleAppBar;

  const LoadingScreen({super.key, required this.titleAppBar});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titleAppBar),
      ),
      body: const Center(
        child: CircularProgressIndicator(
          color: Colors.lightBlue
        ),
      ),
    );
  }
}