import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:techconnect_frontend/providers/profile/complete_profile_provider.dart';
import 'package:techconnect_frontend/providers/profile/invite_friends_provider.dart';
import 'package:techconnect_frontend/screens/auth/check_auth_screen.dart';
import 'package:techconnect_frontend/screens/auth/forgor_password_screen.dart';
import 'package:techconnect_frontend/screens/auth/login_screen.dart';
import 'package:techconnect_frontend/screens/auth/register_user_screen.dart';
import 'package:techconnect_frontend/screens/auth/reset_password_screen.dart';
import 'package:techconnect_frontend/screens/home_screen.dart';
import 'package:techconnect_frontend/screens/profile/complete-profile/add_location_screen.dart';
import 'package:techconnect_frontend/screens/profile/complete-profile/complete_profile_screen.dart';
import 'package:techconnect_frontend/screens/profile/complete-profile/invite_friends_screen.dart';
import 'package:techconnect_frontend/services/auth_service.dart';
import 'package:techconnect_frontend/services/context_service.dart';
import 'package:techconnect_frontend/services/notification_service.dart';
import 'package:techconnect_frontend/services/user_profile_servide.dart';
import 'package:techconnect_frontend/config/app_config.dart';

// void main() => runApp(AppState());
void main() async {
  await dotenv.load(fileName: "./.env");
  runApp(AppState());
}


class AppState extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService()),
        ChangeNotifierProvider(create: (context) => UserProfileService()),
        ChangeNotifierProvider(create: (context) => CompleteProfileProvider(),),
        ChangeNotifierProvider(create: (context) => InviteFriendsProvider())
      ],
      child: const MyApp(),
    );
  }

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    print(AppConfig.API_URL);
    ContextService().setContext(context);
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
        'add-location': (context) => const AddLocationScreen(),
        'invite-friends': (context) => InviteFriendsScreen(userProfileId: 1),
        'home':(context) => const HomeScreen(),
      },
      scaffoldMessengerKey: NotificationService.messengerKey,
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.grey[300]
      ),
    );
  }

}