import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'KolokviumCard.dart';
import 'NotificationService.dart';
import 'Predmeti.dart';
import 'KolokviumInputScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'CalendarScreen.dart';
import 'LoginPage.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  NotificationService().initNotification();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  Predmeti predmeti = Predmeti();
  bool showList = true;
  bool showCalendar = false;
  bool loginScreenIsActive = true;
  String date = "";
  String username = "";
  //String userId;

  void deletePredmet(String title, String date) {
    setState(() {
      predmeti.delete(title, date);
      print(predmeti.length);
    });
  }

  void addPredmet(String title, String date) {
    setState(() {
      predmeti.add(title, date);
    });
  }

  void showCalendarr() {
    setState(() {
      showList = false;
      showCalendar = true;
    });
  }

  void back() {
    setState(() {
      showList = true;
      showCalendar = false;
    });
  }

  void dateToSort(String date1) {
    this.date = date1;
  }

  void clearDateSort() {
    this.date = "";
  }

  void login(String username) {
    setState(() {
      loginScreenIsActive = false;
      this.username = username;
    });
  }

  Widget check() {
    if (loginScreenIsActive) return LoginPage(login);

    if (showList && !showCalendar) {
      if (date == "") {
        return ListView.builder(
          itemCount: predmeti.length,
          itemBuilder: (context, index) {
            return KolokviumCard(
                predmeti[index].title, predmeti[index].date, deletePredmet);
          },
        );
      } else
        // ignore: curly_braces_in_flow_control_structures
        return ListView.builder(
          itemCount: predmeti.length,
          itemBuilder: (context, index) {
            if (date == predmeti[index].date) {
              print(date);
              return KolokviumCard(
                  predmeti[index].title, predmeti[index].date, deletePredmet);
            } else
              return SizedBox.shrink();
          },
        );
    } else if (!showList && !showCalendar) {
      return KolokviumInputScreen(back, addPredmet);
    } else {
      return CalendarScreen(back, dateToSort, clearDateSort);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "kolokviumi",
        home: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: const Text('Kolokviumi'),
              actions: <Widget>[
                IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () {
                      setState(() {
                        if (!loginScreenIsActive) {
                          if (showList == true) showList = false;
                          showCalendar = true;
                        }
                      });
                    }),
                IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        if (!loginScreenIsActive) {
                          if (showList == true) showList = false;
                          if (showCalendar == true) showCalendar = false;
                        }
                      });
                    })
              ],
            ),
            body: check()));
  }
}
