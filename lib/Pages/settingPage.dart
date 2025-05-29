import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:projek/Widgets/customBottomNavBar.dart';
import 'package:projek/Widgets/grayContainer.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Naam:Alden 
// Van: Peach
// Studente Nr: 2023010376

// DOEL VAN DIE PAGE
// ################################################################
// % Laat toe dat die tema vir die hele toepassing verander word %
// Kan dus tussen lig- en donkermodus wissel.
// NB: logika vir "state" hanteering van die tema's in in die Main.dart leer.
class Settingpage extends StatefulWidget {
  // erf metode om theme te verander vanaf main
  final bool isDarkMode;
  final Function(bool) toggleThemeMode;

  const Settingpage({
    super.key,
    required this.isDarkMode,
    required this.toggleThemeMode,
  });

  @override
  State<Settingpage> createState() => _SettingpageState();
}

class _SettingpageState extends State<Settingpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 2),
      body: Stack(
        children: [
          SizedBox.expand(
            child: SvgPicture.asset(
              widget.isDarkMode
                  ? 'assets/background_black.svg'
                  : 'assets/background_white.svg',
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: greyContainer(context),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text("Darkmode toggle:"),
                      const SizedBox(height: 8),
                      Switch(
                        // Verander hier die theme
                        value: widget.isDarkMode,
                        onChanged: widget.toggleThemeMode,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
