import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techconnect_frontend/services/auth_service.dart';

class CompleteProfileScreen extends StatelessWidget {
   
  const CompleteProfileScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        leading: IconButton(
          icon: const Icon(Icons.login_outlined),
          color: Colors.black,
          onPressed: () {
            authService.signOut();
            Navigator.pushReplacementNamed(context, 'login');
          },
        ),
      ),
      body: const Center(
         child: Text('CompleteProfileScreen'),
      ),
    );
  }
}