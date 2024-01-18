import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class KolokviumInputScreen extends StatelessWidget {
  Function back;
  Function add;
  String name = "";
  String date = "";
  KolokviumInputScreen(this.back, this.add);
  final TextEditingController textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            TextFormField(
              controller: textController,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter Subject name',
              ),
            ),
            SizedBox(
              height: 500,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                minimumDate: DateTime.utc(1989, 11, 9),
                maximumDate: DateTime.now().add(const Duration(days: 365)),
                initialDateTime: DateTime(2020, 1, 1),
                onDateTimeChanged: (DateTime newDateTime) {
                  final DateFormat formatter = DateFormat('dd-MM-yyyy');
                  final String formatted = formatter.format(newDateTime);
                  date = formatted;
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue,
                  ),
                  child: const Text("Back"),
                  onPressed: () {
                    back();
                  },
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue,
                  ),
                  child: const Text("Done"),
                  onPressed: () {
                    if (textController.text != "" && date != "") {
                      String title = textController.text;
                      add(title, date);
                      Timer(Duration(seconds: 1), () {
                        // Code to run after 2 seconds
                        back();
                      });
                    } else {
                      const snackBar = SnackBar(
                        content: Text('Yay! A SnackBar!'),
                      );
                    }
                  },
                ),
              ],
            )
          ],
        ));
  }
}
