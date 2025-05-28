import 'package:flutter/material.dart';
import 'package:projek/Pages/addKennisgewingPage.dart';
import 'package:projek/Pages/tuisbladPage.dart';
import 'package:projek/Theme/appColors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
        '/': (context) => const Tuisbladpage(),
        // '/page2': (context) => const Page2(),
        '/addKennisgewing': (context) => const Addkennisgewingpage(),

      },
      theme: ThemeData(
        primaryColor: AppColors.slate,
        primaryColorDark: AppColors.navy,
        primaryColorLight: Colors.white,
        scaffoldBackgroundColor: Colors.white,

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
          titleSmall: TextStyle(color: AppColors.navy , fontWeight: FontWeight.bold),

          // Body text + labels in slate
          bodyLarge: TextStyle(color: AppColors.slate),
          bodyMedium: TextStyle(color: Colors.grey),
          bodySmall: TextStyle(color: Colors.grey ),
          labelLarge: TextStyle(color: AppColors.slate),
          labelMedium: TextStyle(color: AppColors.slate),
          labelSmall: TextStyle(color: AppColors.slate),
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: AppColors.navy,
        )
      ),

    );
  }
}






