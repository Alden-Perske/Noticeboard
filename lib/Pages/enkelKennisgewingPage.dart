import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:projek/Pages/addKennisgewingPage.dart';
import 'package:projek/Theme/appColors.dart';
import 'package:projek/Widgets/customConfrimDialog.dart';
import 'package:projek/Widgets/customDialog.dart';
import 'package:projek/Widgets/grayContainer.dart';
import 'package:projek/services/firestore.dart';
import 'package:projek/services/logleer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Enkelkennisgewingpage extends StatefulWidget {
  final String titel;
  final String teks;
  final String kategorie;
  final String datum;
  final String skrywer;
  final String id;
  final bool isDarkMode;
  final Function(bool) toggleThemeMode;

  const Enkelkennisgewingpage({
    super.key,
    required this.titel,
    required this.teks,
    required this.kategorie,
    required this.datum,
    required this.skrywer,
    required this.id,
    required this.isDarkMode, 
    required this.toggleThemeMode
  });
  

  @override
  State<Enkelkennisgewingpage> createState() => _EnkelkennisgewingpageState();
}

class _EnkelkennisgewingpageState extends State<Enkelkennisgewingpage> {

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
  Firestore firestore = Firestore();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.titel)),
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
            ),
            ),

            // Foreground scrollable content
            SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  width: double.infinity,
                  decoration: greyContainer(context),
                  padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          getSvg(widget.kategorie),
                          Expanded(
                            child: Text(
                              widget.titel,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        color: Theme.of(context).primaryColor,
                        thickness: 2,
                        indent: 16,
                        endIndent: 16,
                      ),
                      const SizedBox(height: 4),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 16),
                            child: Text(
                              widget.datum,
                              style: Theme.of(context).textTheme.bodyMedium
                            ),
                          ),
                          
                        ],
                      ),
                      const SizedBox(height: 8),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        
                        children: [
                          Icon(Icons.account_circle_outlined , size: 40, color: Theme.of(context).primaryColorDark,),
                          SizedBox(width: 15,),
                          Text(
                            widget.skrywer,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      Text(
                        "Teks:",
                        
                        style: Theme.of(context).textTheme.titleMedium,
                        textAlign: TextAlign.start,
                      ),
                      Text(
                        widget.teks,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 16),

                      Text(
                        "Kategorie:",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        widget.kategorie,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 16),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              style: ButtonStyle(
                                padding: WidgetStatePropertyAll(
                                  EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                                ),
                                backgroundColor: WidgetStateProperty.all(
                                  Theme.of(context).primaryColorDark,
                                ),
                                foregroundColor: WidgetStatePropertyAll(Theme.of(context).primaryColorLight)
                              ),
                              onPressed: () {
                                Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (context) => Addkennisgewingpage(
                                              titel: widget.titel,
                                              teks: widget.teks,
                                              skrywer: widget.skrywer,
                                              kategorie: widget.kategorie,
                                              id: widget.id,
                                              datum: widget.datum,
                                              isDarkMode: widget.isDarkMode,
                                              toggleThemeMode: widget.toggleThemeMode,
                                            ),
                                      ),
                                    );
                              },
                              child: Text("   Edit   "),
                            ),
                            SizedBox(width: 8,),
                            ElevatedButton(
                              style: ButtonStyle(
                                padding: WidgetStatePropertyAll(
                                  EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                                ),
                                backgroundColor: WidgetStateProperty.all(
                                  Theme.of(context).primaryColorLight,
                                ),
                                foregroundColor: WidgetStatePropertyAll(
                                  Theme.of(context).primaryColorDark,
                                ),
                                shape: WidgetStatePropertyAll(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100), // Optional rounded corners
                                    side: BorderSide(
                                      color: Theme.of(context).primaryColorDark, // Border color
                                      width: 2,          // Border width
                                    ),
                                  ),
                                ),
                              ),
                              onPressed: () async {
                                bool? pressedConfirm = await showConfirmationDialog(context,"Are you sure you want to delete this post with title:${widget.titel}?","Verwyder kennigewing");
                                if(pressedConfirm == true){
                                  logleer.logKennisgewing(widget.titel, "DELETE: ${widget.titel} is verwyder");
                                  firestore.verwyderKennisgewing(id: widget.id);
                                  Navigator.pushNamed(context, '/');
                                  showCustomDialog(context, "Deleted post with title ${widget.titel}.", "Kennisgewing is verwyder");

                                }
                              },
                              child: Text("Delete"),
                            ),
                            
                        ],
                      ),
                      const SizedBox(height: 16),

                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// String verkortTitel(String titel) {
//   if (titel.length >= 20) {
//     return titel.substring(0, 20);
//   } else {
//     return titel; // or some default value
//   }
// }

SvgPicture getSvg(String kategorie) {
  String kategorieIkoon = '';
  Color kleurVanIkoon = AppColors.navy;
  if (kategorie == 'akademie') {
    kategorieIkoon = 'assets/menu_book.svg';
    kleurVanIkoon = AppColors.blue;
  }
  if (kategorie == 'ander') {
    kategorieIkoon = 'assets/question_mark.svg';
    kleurVanIkoon = AppColors.yellow;
  }
  if (kategorie == 'velore goed') {
    kategorieIkoon = 'assets/personal_bag_question.svg';
    kleurVanIkoon = AppColors.orange;
  }
  return SvgPicture.asset(
    kategorieIkoon,
    height: 44,
    width: 44,
    colorFilter: ColorFilter.mode(kleurVanIkoon, BlendMode.srcIn),
  );
}
