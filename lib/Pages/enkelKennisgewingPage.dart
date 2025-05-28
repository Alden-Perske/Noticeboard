import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:projek/Pages/addKennisgewingPage.dart';
import 'package:projek/Theme/appColors.dart';
import 'package:projek/Widgets/grayContainer.dart';

class Enkelkennisgewingpage extends StatefulWidget {
  final String titel;
  final String teks;
  final String kategorie;
  final String datum;
  final String skrywer;
  final String id;

  const Enkelkennisgewingpage({
    super.key,
    required this.titel,
    required this.teks,
    required this.kategorie,
    required this.datum,
    required this.skrywer,
    required this.id,
  });
  

  @override
  State<Enkelkennisgewingpage> createState() => _EnkelkennisgewingpageState();
}

class _EnkelkennisgewingpageState extends State<Enkelkennisgewingpage> {
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
                'assets/background_white.svg',
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
                          Text(
                            widget.titel,
                            style: Theme.of(context).textTheme.displayMedium,
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
                              onPressed: () {
                                
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
