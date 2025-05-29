import 'package:flutter/material.dart';

// Naam:Alden 
// Van: Peach
// Studente Nr: 2023010376

Future<bool?> showConfirmationDialog(BuildContext context, String message, String dialogTitle) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(dialogTitle),
        backgroundColor: Theme.of(context).primaryColorLight,
        content: Text(message),
        actions: [
          
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true); // return dan true
            },
            child: Text('Ja'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false); // return dan false
            },
            child: Text('Nee'),
          ),
        ],
      );
    },
  );
}
