import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class LoginPage extends StatefulWidget {
  Function login;

  LoginPage(this.login);
  @override
  _LoginPage createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  final TextEditingController textController1 = TextEditingController();
  final TextEditingController textController2 = TextEditingController();
  var allData;
  /*final TextEditingController textController = TextEditingController();
  CollectionReference students = FirebaseFirestore.instance.collection('Users');

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            TextFormField(
              controller: textController,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Username',
              ),
            ),
            TextFormField(
              controller: textController,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Password',
              ),
            ),
            TextButton(
                child: Text("Login"),
                style: TextButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white),
                onPressed: () {})
          ],
        ));
  }*/
  final String documentId = "";

  //GetStudentName(this.documentId);
  CollectionReference users = FirebaseFirestore.instance.collection('Users');

  Future<void> getData() async {
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

    //var t = allData1. ;

    //Map<String, dynamic> data = allData as Map<String, dynamic>;
    this.allData = allData;
    //print(t);
  }

  bool checkUser(String username, String password) {
    //print(allData);
    for (int i = 0; i < allData.length; i++) {
      String test = jsonEncode(allData[i]);
      if (username == jsonDecode(test)['Username'] &&
          password == jsonDecode(test)['Password']) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    getData();

    return Container(
        padding: const EdgeInsets.all(5),
        child: Column(children: [
          TextFormField(
            controller: textController1,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Username',
            ),
          ),
          TextFormField(
            controller: textController2,
            obscureText: true,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Password',
            ),
          ),
          TextButton(
              child: Text("Login"),
              style: TextButton.styleFrom(
                  backgroundColor: Colors.blue, foregroundColor: Colors.white),
              onPressed: () {
                setState(() {
                  if (checkUser(textController1.text, textController2.text)) {
                    //print("works");
                    this.widget.login(textController1.text);
                  }
                });
              }),
        ]));
  }
}
