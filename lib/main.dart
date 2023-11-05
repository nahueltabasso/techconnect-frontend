import 'package:flutter/material.dart';
import 'package:techconnect_frontend/screens/auth/login_screen.dart';
import 'package:techconnect_frontend/screens/auth/register_user_screen.dart';
import 'package:techconnect_frontend/screens/home_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TechConnection',
      initialRoute: 'login',
      routes: {
        'login':(context) => const LoginScreen(),
        'home':(context) => const HomeScreen(),
        'register':(context) => const RegisterUserScreen(),
      },
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.grey[300]
      ),
    );
  }
}