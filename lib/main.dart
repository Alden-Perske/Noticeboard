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

// Naam:Alden 
// Van: Peach
// Studente Nr: 2023010376

// DOEL VAN DIE PAGE
// ################################################################
// % Skep routes en koppel hulle aan Pages %
// % Hou logika vir 'state' hantering van die verskillende temas wat gebruik word %
// NB: Fisiese tema's se eienskappe word gehou onder Themes vouer onder darkModeTheme en lightModeTheme
// % Laat toe dat die Flutter app gekoppel is aan Firestore %


// % Laat toe dat die Flutter app gekoppel is aan Firestore %
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

// % Hou logika vir 'state' hantering van die verskillende temas wat gebruik word %

// bool hou dop as die toepassing in darkmode of lightmode is
  bool _isDarkMode = false;

// Laai Gestoorde Preference 
  @override
  void initState() {
    super.initState();
    _loadThemePreference();
  }

  // Hierdie funksie gebruik SharedPreferences.getInstance() om toegang te kry tot plaaslike persistent storage.
  // Dit kyk of daar 'n "key" is met die naam darkMode en indein nie is dit na lightmode toe gestel (false)
   void _loadThemePreference() async {
    final mode = await SharedPreferences.getInstance();
    setState(() {
      _isDarkMode = mode.getBool('darkMode') ?? false; // default to light mode
    });
  }

  // Die funksie stoor in plaaslike persistent storage as darkmode (boolean) vals of waar is
  void _saveThemeMode(bool waarde) async{
    final mode = await SharedPreferences.getInstance();
    await mode.setBool("darkMode", waarde);
  }

  // Verander booleaan waarde na sy teenoorgestelde.
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

      // isDarkMode: vertel die bladsy of die app in donker of lig tema is.
      routes: {
        '/': (context) =>  Tuisbladpage(
          isDarkMode: _isDarkMode,
        ),
        '/settings': (context) => Settingpage(
        isDarkMode: _isDarkMode,
        toggleThemeMode: _toggleThemeMode,
      ),
        '/addKennisgewing': (context) =>  Addkennisgewingpage(
          isDarkMode: _isDarkMode,
        ),
        '/logs': (context) =>  LogsPage(
          isDarkMode: _isDarkMode,
          toggleThemeMode: _toggleThemeMode,
        ),

      },
      // Dit stel die ligte en donker tema's wat die app gebruik.
      theme: lightMode,
      darkTheme: darkMode,
      // Bepaal watter tema aktief is:
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,

    );
  }
}






