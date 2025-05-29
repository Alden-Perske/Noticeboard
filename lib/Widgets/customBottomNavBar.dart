import 'package:flutter/material.dart';

/// Custom Bottom Navigation Widget
class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  const CustomBottomNavBar({super.key, required this.currentIndex});

  static const List<String> _routes = ['/', '/addKennisgewing', '/settings' ,'/logs'];

  // Method om paths te koppel aan knoppie
  //Dit vergelyk of die nuwe item waarop geklik is nie reeds 
  //die huidige een is nie.
  void _onItemTapped(BuildContext context, int index) {
    if (index != currentIndex) {
      Navigator.pushReplacementNamed(context, _routes[index]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      // .fixed forseer agtergrond kleur af flutter se theme defalut verander as meer as 4 items 
      // by bottom navigation bygevoeg is
       type: BottomNavigationBarType.fixed, 
      backgroundColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
      currentIndex: currentIndex,
      onTap: (index) => _onItemTapped(context, index),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_circle),
          label: 'Add',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.description),
          label: 'Logs',
        ),
      ],
    );
  }
}