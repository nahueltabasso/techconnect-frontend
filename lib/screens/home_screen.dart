import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techconnect_frontend/providers/navigation/navigation_provider.dart';
import 'package:techconnect_frontend/screens/messenger/chat_screen.dart';
import 'package:techconnect_frontend/screens/notifications/notification_screen.dart';
import 'package:techconnect_frontend/screens/post/post_list_screen.dart';
import 'package:techconnect_frontend/screens/profile/profile/friends_screen.dart';
import 'package:techconnect_frontend/screens/profile/profile/profile_screen.dart';
import 'package:techconnect_frontend/widgets/custom_bottom_navigation.dart';

class HomeScreen extends StatelessWidget {
   
  const HomeScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NavigationProvider(),
      child: const Scaffold(
        body: _Pages(),
        bottomNavigationBar: CustomBottomNavigation(),
      ),
    );
  }
}

class _Pages extends StatelessWidget {

  const _Pages({ super.key });

  @override
  Widget build(BuildContext context) {
    
    final navigationProvier = Provider.of<NavigationProvider>(context);

    return PageView(
      controller: navigationProvier.pageController,
      // physics: const BouncingScrollPhysics(),
      physics: const NeverScrollableScrollPhysics(),
      children: const [
        // Container(color: Colors.red),
        PostListScreen(),
        FriendsScreen(),
        ChatScreen(),
        NotificationScreen(),
        ProfileScreen()
      ],
    );
  }
}