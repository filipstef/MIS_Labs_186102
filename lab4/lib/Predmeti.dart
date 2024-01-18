import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'DataAccess.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'NotificationService.dart';
import 'Predmet.dart';

class Predmeti {
  List<Predmet> _predmeti = [];
  var allData;

  Predmeti() {
    print(_predmeti);
    fetchPredmeti();
  }

  Future<void> fetchPredmeti() async {
    _predmeti = await Predmet.readPredmeti();
  }

  int get length {
    return _predmeti.length;
  }

  Predmet operator [](int index) {
    return _predmeti[index];
  }

  Future<void> add(String title, String date) async {
    await Predmet.addPredmet(title, date);
    Predmet p = new Predmet(title: title, date: date);
    //await showNotification(p);
    fetchPredmeti();
    NotificationService()
        .showNotification(title: 'Added subject:' + title, body: '');
  }

  Future<void> delete(title, date) async {
    Predmet predmet = Predmet(title: title, date: date);
    _predmeti.removeWhere(
        (element) => element.title == title && element.date == date);
    await Predmet.deletePredmetByNameAndDate(title, date);
  }
}
