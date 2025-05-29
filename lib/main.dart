import 'package:flutter/material.dart';
import 'package:projek/Pages/addKennisgewingPage.dart';
import 'package:projek/Pages/logsPage.dart';
import 'package:projek/Pages/settingPage.dart';
import 'package:projek/Pages/tuisbladPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:projek/Theme/darkModeTheme.dart';
import 'package:projek/Theme/lightModeTheme.dart';
import 'firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {

  bool _isDarkMode = false;

  @override
  void initState() {
    super.initState();
    _loadThemePreference();
  }

  // Load the saved theme preference from SharedPreferences
  void _loadThemePreference() async {
    final mode = await SharedPreferences.getInstance();
    setState(() {
      _isDarkMode = mode.getBool('darkMode') ?? false; // default to light mode
    });
  }

  void _saveThemeMode(bool waarde) async{
    final mode = await SharedPreferences.getInstance();
    await mode.setBool("darkMode", waarde);
  }

  void _toggleThemeMode(bool waarde) async{
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
    _saveThemeMode(_isDarkMode);
  }
  // Skep routes en koppel hulle aan Pages
  // Die parameters hieronder laat toe dat elke page weet watter
  // tema gebruik words
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigation App',
      initialRoute: '/',
      routes: {
        '/': (context) =>  Tuisbladpage(
          isDarkMode: _isDarkMode,
          toggleThemeMode: _toggleThemeMode,
        ),
        '/settings': (context) => Settingpage(
        isDarkMode: _isDarkMode,
        toggleThemeMode: _toggleThemeMode,
      ),
        '/addKennisgewing': (context) =>  Addkennisgewingpage(
          isDarkMode: _isDarkMode,
          toggleThemeMode: _toggleThemeMode,
        ),
        '/logs': (context) =>  LogsPage(
          isDarkMode: _isDarkMode,
          toggleThemeMode: _toggleThemeMode,
        ),

      },
      theme: lightMode,
      darkTheme: darkMode,
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,

    );
  }
}






