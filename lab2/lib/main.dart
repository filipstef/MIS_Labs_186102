import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lab2/clothes_answer.dart';
import 'package:lab2/clothes_question.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  List<dynamic> questions = [
    {
      "question": "Select type of clothes",
      "answer": [
        "T-shirt",
        "Jeans",
        "Jacket",
      ],
    },
    {
      "question": "Select color",
      "answer": [
        "Green",
        "Yellow",
        "Black",
      ],
    },
    {
      "question": "Select size",
      "answer": [
        "Large",
        "Medium",
        "Small",
      ],
    },
  ];

  var _questionIndex = 0;
  String finalAnswer = "";
  bool isPressed = false;

  void _iWasTapped(String text) {
    setState(() {
      if (_questionIndex < questions.length - 1)
        _questionIndex += 1;
      else
        isPressed = true;
    });
    finalAnswer += " " + text;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Clothing Selection",
        home: Scaffold(
            appBar: AppBar(title: Text("Select Clothing")),
            body: Column(
              children: [
                if (isPressed == false) ...[
                  ClothesQuestion(questions[_questionIndex]['question']),
                  ClothesAnswer(
                      _iWasTapped, questions[_questionIndex]['answer'][0]),
                  ClothesAnswer(
                      _iWasTapped, questions[_questionIndex]['answer'][1]),
                  ClothesAnswer(
                      _iWasTapped, questions[_questionIndex]['answer'][2]),
                ] else
                  ClothesQuestion(finalAnswer),
              ],
            )));
  }
}
