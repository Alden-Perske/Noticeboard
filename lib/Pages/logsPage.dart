import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:projek/Widgets/customBottomNavBar.dart';
import 'package:projek/Widgets/grayContainer.dart';
import 'package:projek/services/logleer.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  Future<void> _toggleMode(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('darkMode', value);
    setState(() {
      _isDarkMode = value;
    });
  }

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
        // Make sure Stack fills full screen
        child: Stack(
          children: [
            // Background SVG
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
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error loading logs: ${snapshot.error}');
                    } else {
                      return Text(snapshot.data?.isNotEmpty == true 
                        ? snapshot.data! 
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