import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';



class Firestore {

  // get collection of kennisgewings
  final CollectionReference kennisgewings = FirebaseFirestore.instance.collection('kennisgewings');

  //CREATE
  Future<void> addKennisgewing (String titel , String teks , String skrywer , String kategorie)async {
    // Gebruik nou dadelik se tyd
    DateTime now = DateTime.now();
    String datum = DateFormat('yyyy-MM-dd – kk:mm').format(now);

    var uuid = Uuid(); // Skep 'n uuid "instance"
    String id = uuid.v4(); // Skep 'n random 128 bit id

    kennisgewings.add({
      'id':id,
      'titel':titel,
      'teks':teks,
      'skrywer':skrywer,
      'kategorie':kategorie,
      'datum':datum
    });

  }
  // READ
  Stream<QuerySnapshot> getAlmalKennisgewing(String kategorie) {
  if (kategorie == "almal") {
    return kennisgewings
        .orderBy('datum', descending: true)
        .snapshots();
  } else {
    return kennisgewings
        .where('kategorie', isEqualTo: kategorie)
        .orderBy('datum', descending: true)
        .snapshots();
  }
}

  // UPDATE
  Future<void> opdateerKennisgewing({
  required String titel,
  required String teks,
  required String kategorie,
  required String datum,
  required String skrywer,
  required String id,
  }) async {
    return kennisgewings.doc(id).update({
      'id':id,
      'titel':titel,
      'teks':teks,
      'skrywer':skrywer,
      'kategorie':kategorie,
      'datum':datum
    });
  }

  // DELETE
}