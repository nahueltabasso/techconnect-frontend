import 'package:flutter/material.dart';

class NavigationProvider extends ChangeNotifier {

  int _currentPage = 0;
  PageController _pageController = PageController(initialPage: 0);

  int get currentPage => _currentPage;

  set currentPage(int value) {
    _currentPage = value;
    _pageController.animateToPage(value, duration: const Duration(milliseconds: 250), curve: Curves.easeOut);
    notifyListeners();
  }

  PageController get pageController => _pageController;
}