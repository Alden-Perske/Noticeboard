import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:projek/Pages/loginPage.dart';
import 'package:projek/Theme/appColors.dart';
import 'package:projek/Widgets/customBottomNavBar.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigation App',
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/page1': (context) => const Page1(),
        '/page2': (context) => const Page2(),

      },
      theme: ThemeData(
        primaryColor: AppColors.slate,
        scaffoldBackgroundColor: AppColors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.slate,
          foregroundColor: Colors.white,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: AppColors.slate,
          selectedItemColor: AppColors.white,
          unselectedItemColor: AppColors.lavender,
        ),
        textTheme: const TextTheme(
          
          displayLarge: TextStyle(color: AppColors.navy),
          displayMedium: TextStyle(color: AppColors.navy),
          displaySmall: TextStyle(color: AppColors.navy),
          headlineLarge: TextStyle(color: AppColors.navy),
          headlineMedium: TextStyle(color: AppColors.navy),
          headlineSmall: TextStyle(color: AppColors.navy),
          titleLarge: TextStyle(color: AppColors.navy),
          titleMedium: TextStyle(color: AppColors.navy),
          titleSmall: TextStyle(color: AppColors.navy),

          // Body text + labels in slate
          bodyLarge: TextStyle(color: AppColors.slate),
          bodyMedium: TextStyle(color: AppColors.slate),
          bodySmall: TextStyle(color: AppColors.slate),
          labelLarge: TextStyle(color: AppColors.slate),
          labelMedium: TextStyle(color: AppColors.slate),
          labelSmall: TextStyle(color: AppColors.slate),
        ),
      ),

    );
  }
}



class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background SVG
          Positioned.fill(
            child: SvgPicture.asset(
              'assets/background_white.svg',
              fit: BoxFit.cover,
            ),
          ),
          // Foreground content
          const Center(
            child: Text('Home Screen'),
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 0),
    );
  }
}

/// Page 1
class Page1 extends StatelessWidget {
  const Page1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Page 1')),
      body: const Center(child: Text('This is Page 1')),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 1),
    );
  }
}

/// Page 2
class Page2 extends StatelessWidget {
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Page 2')),
      body: const Center(child: Text('This is Page 2')),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 2),
    );
  }
}
