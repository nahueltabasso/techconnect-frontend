import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techconnect_frontend/providers/navigation/navigation_provider.dart';

class CustomBottomNavigation extends StatelessWidget {
  const CustomBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    
    final navigationProvider = Provider.of<NavigationProvider>(context);

    return BottomNavigationBar(
      showSelectedLabels: true,
      showUnselectedLabels: true,
      selectedItemColor: Colors.lightBlue,
      // backgroundColor: Colors.white,
      unselectedItemColor: Colors.black,
      currentIndex: navigationProvider.currentPage,
      onTap: (value) => navigationProvider.currentPage = value,
      items: const [

        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Inicio'
        ),

        BottomNavigationBarItem(
          icon: Icon(Icons.people_alt_rounded),
          label: 'Amigos'
        ),

        BottomNavigationBarItem(
          icon: Icon(Icons.chat),
          label: 'Chat'
        ),

        BottomNavigationBarItem(
          icon: Icon(Icons.notification_important),
          label: 'Notificaciones'
        ),

        BottomNavigationBarItem(
          icon: CircleAvatar(radius: 15, child: Icon(Icons.person)),
          label: 'Menu'
        ),

      ],
    );
  }
}