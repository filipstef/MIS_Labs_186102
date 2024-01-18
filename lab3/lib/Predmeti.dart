import 'package:flutter/material.dart';
import 'predmet.dart';

class Predmeti {
  List<Predmet> _predmeti = [];

  Predmeti() {
    _predmeti = [
      Predmet('Napredno Programiranje', '21-01-2023'),
      Predmet('Bazi na Podatoci', '16-01-2023'),
      Predmet('Algoritmi i Podatocni strukturi', '01-02-2023'),
      Predmet('Mobilni informaciski sistemi', '15-02-2023')
    ];
  }

  int get length {
    return _predmeti.length;
  }

  Predmet operator [](int index) {
    return _predmeti[index];
  }

  void add(String title, String date) {
    _predmeti.add(Predmet(title, date));
  }

  void delete(title, date) {
    Predmet predmet = Predmet(title, date);
    _predmeti.removeWhere(
        (element) => element.title == title && element.date == date);
  }
}
