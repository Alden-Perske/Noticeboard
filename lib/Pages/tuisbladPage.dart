import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:projek/Pages/enkelKennisgewingPage.dart';
import 'package:projek/Theme/appColors.dart';
import 'package:projek/Theme/darkModeTheme.dart';
import 'package:projek/Widgets/customBottomNavBar.dart';
import 'package:projek/Widgets/grayContainer.dart';
import 'package:projek/services/firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Tuisbladpage extends StatefulWidget {
  final bool isDarkMode;
  final Function(bool) toggleThemeMode;
  const Tuisbladpage({super.key , required this.isDarkMode, required this.toggleThemeMode});
  

  @override
  State<Tuisbladpage> createState() => _TuisbladpageState();
}

class _TuisbladpageState extends State<Tuisbladpage> {

  bool _isDarkMode = false;

  @override
  void initState() {
    super.initState();
    gekiesdeKatogorie = kategorieList[0]; 
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

  Firestore firestore = Firestore();
  List<String> kategorieList = ["almal" , "akademie" , "velore goed" , "ander"];
  late String gekiesdeKatogorie;

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tuisblad") , leading: SvgPicture.asset('assets/griffonSVG.svg'),),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 0),
      body: Stack(
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
          // Safearea sit automaties padding by sodat dit nie agter 
          // "onveilige areas" oorvleuel nie soos 'n front facing kamera ens.
          SafeArea(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height - kToolbarHeight,
              ),

              // Bevat Dropdownbutton wat keuse gee tussen verskillende kategoriee
              // en dit afhangende van kategorie filtreer
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(8),
                    padding: EdgeInsets.all(8),
                    child: DropdownButton<String>(

                      value: gekiesdeKatogorie,
                      items: kategorieList.map((String kategorie) {
                        return DropdownMenuItem<String>(
                          value: kategorie,
                          child: Text(kategorie),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          gekiesdeKatogorie = newValue!;
                        });
                      },
                    ),
                  ),

                  // Gebruik expanded omdat anders gaan flutter 'n viewport error gee

                  // Streambuilder bevat s
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: StreamBuilder<QuerySnapshot>(
                        // Kry lys of straam van json objects vanaf firbase db
                        // Die firestore metode getAlmalKennisgewing filtreer die items 
                        // volgens kategorie
                        stream: firestore.getAlmalKennisgewing(gekiesdeKatogorie),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List kennisgewingsList = snapshot.data!.docs;
                            return ListView.builder(
                              itemCount: kennisgewingsList.length,
                              itemBuilder: (context, index) {
                                DocumentSnapshot enkelKennisgewing =
                                    kennisgewingsList[index];
                                return Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder:
                                                (context) => Enkelkennisgewingpage(
                                                  titel: enkelKennisgewing.get('titel'),
                                                  teks: enkelKennisgewing.get('teks'),
                                                  skrywer: enkelKennisgewing.get(
                                                    'skrywer',
                                                  ),
                                                  kategorie: enkelKennisgewing.get(
                                                    'kategorie',
                                                  ),
                                                  id: enkelKennisgewing.id,
                                                  datum: enkelKennisgewing.get('datum'),
                                                  isDarkMode: widget.isDarkMode,
                                                  toggleThemeMode: widget.toggleThemeMode,
                                                ),
                                          ),
                                        );
                                      },
                                      child: kennisgewingBar(
                                        enkelKennisgewing.get('titel'),
                                        enkelKennisgewing.get('teks'),
                                        enkelKennisgewing.get('skrywer'),
                                        enkelKennisgewing.get('kategorie'),
                                        enkelKennisgewing.id,
                                        enkelKennisgewing.get('datum'),
                                        context,
                                      ),
                                    ),
                                    Divider(thickness: 1, color: Theme.of(context).primaryColor,)
                                  ],
                                );
                              },
                            );
                          } else {
                            return Center(child: Text("Geen inskrywings nie"));
                          }
                        },
                      ),
                    
                      // child: kennisgewingBar("Eksamen", "Moenie vergeet nie", "Mev. Van Wyk", "akademie", "001", "2025-05-26", context)
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Container kennisgewingBar(
  String titel,
  String teks,
  String skrywer,
  String kategorie,
  String id,
  String datum,
  BuildContext context,
) {
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

  List<String> previewTeks = teks.split(" ");
  

  datum = datum.substring(5, 10);

  return Container(
  margin: EdgeInsets.all(4),
  padding: EdgeInsets.all(8),
  decoration: greyContainer(context),
  child: Column(
    mainAxisSize: MainAxisSize.min, // Add this to prevent infinite height
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [
          SvgPicture.asset(
            kategorieIkoon,
            height: 44,
            width: 44,
            colorFilter: ColorFilter.mode(kleurVanIkoon, BlendMode.srcIn),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  titel,
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Text(datum),
        ],
      ),
      Divider(thickness: 2, color: Theme.of(context).primaryColor,),
      const SizedBox(height: 8),
      Text(
        teks,
        style: Theme.of(context).textTheme.bodyMedium,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    ],
  ),
);
}
