import 'package:flutter/material.dart';
import 'package:projek/Theme/appColors.dart';

// Naam:Alden 
// Van: Peach
// Studente Nr: 2023010376

BoxDecoration greyContainer(BuildContext context) {
  return BoxDecoration(
    color: Theme.of(context).scaffoldBackgroundColor,
    borderRadius: BorderRadius.circular(10),
    boxShadow: [
      BoxShadow(
        blurRadius: 2,
        spreadRadius: 0.5,
        offset: Offset(2, 2),
      ),
    ],
  );
}
