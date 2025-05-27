import 'package:flutter/material.dart';

/// Custom Bottom Navigation Widget
class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  const CustomBottomNavBar({super.key, required this.currentIndex});

  static const List<String> _routes = ['/', '/page1', '/page2'];

  void _onItemTapped(BuildContext context, int index) {
    if (index != currentIndex) {
      Navigator.pushReplacementNamed(context, _routes[index]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) => _onItemTapped(context, index),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.star),
          label: 'Page 1',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Page 2',
        ),
      ],
    );
  }
}