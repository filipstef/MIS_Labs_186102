import 'package:flutter/material.dart';

class ClothesAnswer extends StatelessWidget {
  String answerText;
  Function tapped;
  ClothesAnswer(this.tapped, this.answerText);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
      child: Text(
        answerText,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20, color: Colors.red),
      ),
      onPressed: () {
        tapped(answerText);
      },
    );
  }
}
