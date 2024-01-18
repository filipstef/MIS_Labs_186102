import 'package:flutter/material.dart';
import 'Predmet.dart';
import 'Predmeti.dart';

class KolokviumCard extends StatelessWidget {
  String _kolokTitle;
  String _kolokDate;
  Function delete;
  KolokviumCard(this._kolokTitle, this._kolokDate, this.delete);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Card(
        color: Colors.white54,
        child: Column(
          children: [
            ListTile(
              title: Text(_kolokTitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.black,
                      fontWeight: FontWeight.bold)),
              subtitle: Text(
                _kolokDate,
                style: TextStyle(fontSize: 20, color: Colors.grey),
              ),
            ),
            ButtonBar(
              children: [
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    delete(_kolokTitle, _kolokDate);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /*@override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      height: 100,
      child: Card(
        color: Colors.white54,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Text(
                _kolokTitle,
                style: TextStyle(fontSize: 25, color: Colors.black),
              ),
            ),
            Text(
              textAlign: TextAlign.center,
              _kolokDate,
              style: TextStyle(fontSize: 20, color: Colors.grey),
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                delete(_kolokTitle, _kolokDate);
              },
            ),
          ],
        ),
      ),
    );
  }*/
}
