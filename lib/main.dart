import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techconnect_frontend/screens/auth/check_auth_screen.dart';
import 'package:techconnect_frontend/screens/auth/forgor_password_screen.dart';
import 'package:techconnect_frontend/screens/auth/login_screen.dart';
import 'package:techconnect_frontend/screens/auth/register_user_screen.dart';
import 'package:techconnect_frontend/screens/auth/reset_password_screen.dart';
import 'package:techconnect_frontend/screens/home_screen.dart';
import 'package:techconnect_frontend/screens/profile/complete_profile.dart';
import 'package:techconnect_frontend/services/auth_service.dart';
import 'package:techconnect_frontend/services/notification_service.dart';

void main() => runApp(AppState());


class AppState extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService()),
      ],
      child: const MyApp(),
    );
  }

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TechConnection',
      initialRoute: 'checking',
      routes: {
        'login':(context) => const LoginScreen(),
        'register':(context) => const RegisterUserScreen(),
        'checking':(context) => const CheckAuthScreen(),
        'forgot-password': (context) => const ForgotPasswordScreen(),
        'reset-password': (context) => const ResetPasswordScreen(),
        'complete-profile': (context) => const CompleteProfileScreen(),
        'home':(context) => const HomeScreen(),
      },
      scaffoldMessengerKey: NotificationService.messengerKey,
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.grey[300]
      ),
    );
  }
}