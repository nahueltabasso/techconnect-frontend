import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techconnect_frontend/screens/auth/login_screen.dart';
import 'package:techconnect_frontend/screens/home_screen.dart';
import 'package:techconnect_frontend/services/auth_service.dart';

class CheckAuthScreen extends StatelessWidget {
  const CheckAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: authService.isAuthenticated(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) 
              return Text('Espere');

            Future.microtask(() {
              Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                      pageBuilder: (_, __, ___) => snapshot.data == ''
                          ? const LoginScreen()
                          : const HomeScreen(),
                      transitionDuration: const Duration(seconds: 0)));
            });            return Container();
          },
        ),
      ),
    );
  }
}