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
        backgroundColor: Colors.lightBlue,
        automaticallyImplyLeading: false,
        // leading: IconButton(
        //   icon: const Icon(Icons.login_outlined),
        //   color: Colors.black,
        //   onPressed: () {
        //     authService.signOut();
        //     Navigator.pushReplacementNamed(context, 'login');
        //   },
        // ),
      ),
      body: Center(
        child: Column(
          children: [
            const Text('HomeScreen'),
            const SizedBox(height: 20),
            TextButton(
              child: const Text('Salir'),
              onPressed: () {
                authService.signOut();
                Navigator.pushReplacementNamed(context, 'login');
              },
            )
          ],
        ),
      ),
    );
  }
}