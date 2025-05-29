import 'package:flutter/material.dart';
import 'package:projek/Theme/appColors.dart';

// Naam:Alden 
// Van: Peach
// Studente Nr: 2023010376

InputDecoration grayInputContainer(BuildContext context) {
  return InputDecoration(
    filled: true,
    fillColor: Theme.of(context).scaffoldBackgroundColor,
    contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide.none,
    ),
  );
}

