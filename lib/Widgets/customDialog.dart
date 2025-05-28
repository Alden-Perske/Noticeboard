import 'package:flutter/material.dart';

void showCustomDialog(BuildContext context, String message , String dialogTitle) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(dialogTitle),
        backgroundColor: Theme.of(context).primaryColorLight,
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); 
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}