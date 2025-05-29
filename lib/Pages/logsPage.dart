import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:projek/Widgets/customBottomNavBar.dart';
import 'package:projek/Widgets/grayContainer.dart';
import 'package:projek/services/logleer.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Naam:Alden 
// Van: Peach
// Studente Nr: 2023010376

// DOEL VAN DIE PAGE
// ################################################################
// % Vertoon al die inskrywings in die logleer %
// Funksies:
// - Vertoon alle inskrywings in die logleer
// - Wys dat daar niks is as daar geen inskrywings is nie.
//
// NB: Die logleer is onder Dienste en hou die logika om na 'n teksleer toe te skryf en te lees.


class LogsPage extends StatefulWidget {

  final bool isDarkMode;
  final Function(bool) toggleThemeMode;

  
  const LogsPage({
    super.key,
    required this.isDarkMode,
    required this.toggleThemeMode,
  });

  @override
  State<LogsPage> createState() => _LogsPageState();
}

class _LogsPageState extends State<LogsPage> {

  bool _isDarkMode = false;

  @override
  void initState() {
    super.initState();
    _loadMode();
  }

  Future<void> _loadMode() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkMode = prefs.getBool('darkMode') ?? false;
    });
  }
  // Hanteer promise sodat teks vanaf leer gelees kan word
  Logleer logleer = Logleer();
  Future<String> getLogTeks() async {
    return await logleer.readLogFile();
  }

  

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Text("Logs")),
      bottomNavigationBar: CustomBottomNavBar(currentIndex: 3),
      body: SizedBox.expand(
        child: Stack(
          children: [
            Positioned.fill(
              child: SvgPicture.asset(
              _isDarkMode
                  ? 'assets/background_black.svg'
                  : 'assets/background_white.svg',
              fit: BoxFit.cover,
            ),),

            SafeArea(
              child:SingleChildScrollView(
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.all(8),
                  padding: EdgeInsets.all(8),
                  decoration: greyContainer(context),
                  child: FutureBuilder(future: getLogTeks(), 
                  builder: (context , snapshot) {
                    // Kyk na snapshot se toestand 
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error loading logs: ${snapshot.error}');
                    } else {
                      // As daar data is
                      return Text(snapshot.data?.isNotEmpty == true 
                        ? snapshot.data! // Wys die data
                        : 'Geen logs beskikbaar nie.');
                    }
                  })
                ),
              ))

          ],
        ),
      ));
  }
}