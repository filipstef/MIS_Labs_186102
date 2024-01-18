import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'KolokviumCard.dart';
import 'Predmeti.dart';
import 'Predmet.dart';
import 'KolokviumInputScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  Predmeti predmeti = Predmeti();
  bool showList = true;

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

  void back() {
    setState(() {
      showList = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "kolokviumi",
        home: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Text('Kolokviumi'),
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      if (showList == true) showList = false;
                    });
                  })
            ],
          ),
          body: showList
              ? ListView.builder(
                  itemCount: predmeti.length,
                  itemBuilder: (context, index) {
                    return KolokviumCard(predmeti[index].title,
                        predmeti[index].date, deletePredmet);
                  },
                )
              : KolokviumInputScreen(back, addPredmet),
        ));
  }
}
