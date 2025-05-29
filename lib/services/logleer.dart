import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';


class Logleer {

  // Kry file path vir file waar jy data gaan lees en skryf
  Future<String> getLogFilePath() async {
  final directory = await getApplicationDocumentsDirectory();
  return '${directory.path}/logs.txt';
  }

  // Skryf na log leer toe titel , edit of vetwyder , tyd
  // Skep 'n logs.txt die eerste keer wat hy hardloop
  Future<void> logKennisgewing(String titel, String aksie) async {
  final path = await getLogFilePath();
  final file = File(path);

  DateTime now = DateTime.now();
  String datum = DateFormat('yyyy-MM-dd – kk:mm').format(now);
  String logEntry = "Log titel: ${titel} | aksie: ${aksie} | ${datum}\n" ;

  // writeAsString skryf na leer en FileMode.append  voeg by tot die leer en oorskryf hom nie
  await file.writeAsString(logEntry , mode: FileMode.append);
  }
  // Lees wat in txt leers staan
  Future<String> readLogFile() async {
  final path = await getLogFilePath();
  final file = File(path);
  if (await file.exists()) {
    return await file.readAsString();
  } else {
    return 'No logs yet.';
  }
}
}
