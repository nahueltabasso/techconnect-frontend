import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.login_outlined),
          onPressed: () {
            // authService.signOut();
            // Navigator.pushReplacementNamed(context, 'login');
          },
        ),
      ),
      body: const Center(
         child: Text('ForgotPasswordScreen'),
      ),
    );

  }
}