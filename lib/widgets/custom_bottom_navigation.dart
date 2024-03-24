import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techconnect_frontend/providers/navigation/navigation_provider.dart';
import 'package:techconnect_frontend/providers/profile/user_profile_provider.dart';
import 'package:techconnect_frontend/widgets/circle_avatar_photo.dart';

class CustomBottomNavigation extends StatelessWidget {
  const CustomBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    
    final navigationProvider = Provider.of<NavigationProvider>(context);
    final userProfile = Provider.of<UserProfileProvider>(context).getLoggedUserProfile();
    // final avatarPhotoPath = userProfile.profilePhoto
    return BottomNavigationBar(
      showSelectedLabels: true,
      showUnselectedLabels: true,
      selectedItemColor: Colors.lightBlue,
      // backgroundColor: Colors.white,
      unselectedItemColor: Colors.black,
      currentIndex: navigationProvider.currentPage,
      onTap: (value) => navigationProvider.currentPage = value,
      items: [

        const BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Inicio'
        ),

        const BottomNavigationBarItem(
          icon: Icon(Icons.people_alt_rounded),
          label: 'Amigos'
        ),

        const BottomNavigationBarItem(
          icon: Icon(Icons.chat),
          label: 'Chat'
        ),

        const BottomNavigationBarItem(
          icon: Icon(Icons.notification_important),
          label: 'Notificaciones'
        ),

        BottomNavigationBarItem(
          icon: CircleAvatarPhoto(imagePath: userProfile?.profilePhoto ?? "", radius: 15),
          label: 'Menu'
        ),

      ],
    );
  }
}