import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techconnect_frontend/services/auth_service.dart';

class HomeScreen extends StatelessWidget {
   
  const HomeScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.login_outlined),
          onPressed: () {
            authService.signOut();
            Navigator.pushReplacementNamed(context, 'login');
          },
        ),
      ),
      body: const Center(
         child: Text('HomeScreen'),
      ),
    );
  }
}