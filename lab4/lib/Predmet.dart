import 'package:cloud_firestore/cloud_firestore.dart';

class Predmet {
  String id = "";
  String title;
  String date;

  Predmet({required this.title, required this.date}) {
    String id = new DateTime.now().millisecondsSinceEpoch.toString();
  }

  factory Predmet.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Predmet(
      title: data['Name'],
      date: data['Date'],
    );
  }

  // Read operation
  static Future<List<Predmet>> readPredmeti() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    QuerySnapshot querySnapshot = await firestore
        .collection('Users')
        .doc("bUdF5BTlbhWygBYRtqSr")
        .collection("Predmeti")
        .get();
    List<Predmet> predmetiList = [];
    querySnapshot.docs.forEach((document) {
      Predmet predmet = Predmet.fromFirestore(document);
      predmetiList.add(predmet);
    });
    return predmetiList;
  }

  // Add operation
  static Future<void> addPredmet(String name, String date) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference predmetiCollection = firestore
        .collection('Users')
        .doc("bUdF5BTlbhWygBYRtqSr")
        .collection("Predmeti");
    await predmetiCollection.add({
      'Name': name,
      'Date': date,
    });
  }

  // Delete operation by name and date
  static Future<void> deletePredmetByNameAndDate(
      String name, String date) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    QuerySnapshot querySnapshot = await firestore
        .collection('Users')
        .doc("bUdF5BTlbhWygBYRtqSr")
        .collection("Predmeti")
        .where('Name', isEqualTo: name)
        .where('Date', isEqualTo: date)
        .get();
    List<DocumentSnapshot> documents = querySnapshot.docs;
    for (DocumentSnapshot document in documents) {
      await document.reference.delete();
    }
  }
}
