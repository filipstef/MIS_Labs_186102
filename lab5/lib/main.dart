import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lab4/LocationService.dart';
import 'package:location/location.dart';
import 'KolokviumCard.dart';
import 'Location.dart';
import 'NotificationService.dart';
import 'Predmeti.dart';
import 'KolokviumInputScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'CalendarScreen.dart';
import 'LoginPage.dart';
import 'package:permission_handler/permission_handler.dart' as ph;
import 'LocationService.dart';

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
  bool showLocation = false;
  bool loginScreenIsActive = true;
  String date = "";
  String username = "";
  String? country, adminArea;
  double? lat, long;
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

  void getLocation() async {
    final service = LocationService();
    final locationData = await service.getLocation();

    if (locationData != null) {
      setState(() {
        lat = locationData.latitude!;
        long = locationData.longitude!;
      });
    }
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
    } else if (!showList && !showCalendar && !showLocation) {
      return KolokviumInputScreen(back, addPredmet);
    } else if (showLocation) {
      getLocation();
      return Locations(lat, long, country.toString());
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
                    icon: const Icon(Icons.location_pin),
                    onPressed: () {
                      setState(() {
                        if (!loginScreenIsActive) {
                          if (showList == true && showCalendar == false) {
                            showList = false;
                            showLocation = true;
                          } else if (showList == false &&
                              showCalendar == true) {
                            showCalendar = false;
                            showLocation = true;
                          }
                        }
                      });
                    }),
                IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () {
                      setState(() {
                        if (!loginScreenIsActive) {
                          showCalendar = true;
                          showList = false;
                          showLocation = false;
                        }
                      });
                    }),
                IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        if (!loginScreenIsActive) {
                          showList = true;
                          showCalendar = false;
                          showLocation = false;
                        }
                      });
                    })
              ],
            ),
            body: check()));
  }
}
