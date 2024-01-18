import 'dart:convert';
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lab4/Predmet.dart';

class DatabaseService {
  var allData;

  DatabaseService() {
    //getData();
  }

  Future<void> getData() async {
    CollectionReference users = FirebaseFirestore.instance.collection('Users');
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await users.get();

    // Get data from docs and convert map to List
    var allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    var test = querySnapshot.docs.map((doc) => doc.id).toList();

    CollectionReference predmeti = FirebaseFirestore.instance
        .collection('Users')
        .doc(test.first.toString())
        .collection("Predmeti");
    QuerySnapshot querySnapshot1 = await predmeti.get();

    var t = querySnapshot1.docs.map((doc) => doc.data()).toList();

    //Map<String, dynamic> data = allData as Map<String, dynamic>;
    //this.allData = t;
    //print(t);

    this.allData = t;
  }

  get getAllData async {
    return allData;
  }
}
