import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(calculator_app());
}

class calculator_app extends StatefulWidget {
  @override
  _calculator_appState createState() => _calculator_appState();
}

// List<int> index2 = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15];
var input = '';
bool c = true;
double output;
List<String> button = [
  'c',
  'Del',
  '%',
  '/',
  '9',
  '8',
  '7',
  '*',
  '6',
  '5',
  '4',
  '-',
  '3',
  '2',
  '1',
  '+',
  '0',
  '.',
  'Ans',
  '='
];

class _calculator_appState extends State<calculator_app> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            SizedBox(
              height: 70,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  child: Column(children: [
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        input,
                        style: TextStyle(
                          color: inputcolor(button[button.length - 1]),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                        alignment: Alignment.centerRight,
                        child: Text(
                          '$output',
                          style: TextStyle(fontSize: 35, color: Colors.green),
                        )),
                  ]),
                ),
              ),
            ),
            SizedBox(
              height: 10,
              width: 300,
              child: Divider(
                thickness: 2,
                color: Colors.grey,
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                child: GridView.builder(
                    itemCount: 20,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4, childAspectRatio: 1.3),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: GestureDetector(
                          onTap: () {
                            if (button[index] == 'c') {
                              setState(() {
                                if (input == '') {
                                  print('no exist number to clear it');
                                } else {
                                  input = '';
                                }
                              });
                            } else if (button[index] == '=') {
                              equalbutton();
                            } else if (button[index] == 'Del') {
                              setState(() {
                                if (input == '') {
                                  print('no exist num to delete');
                                } else {
                                  input = input.substring(0, input.length - 1);
                                }
                              });
                            } else {
                              setState(() {
                                input += button[index];
                              });
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: colornum(button[index]) == true
                                  ? Colors.deepPurple
                                  : changecolor(button[index]),
                            ),
                            child: Center(
                              child: Text(
                                button[index].toString(),
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool colornum(String x) {
    if (x == '1' ||
        x == '2' ||
        x == '3' ||
        x == '4' ||
        x == '5' ||
        x == '6' ||
        x == '7' ||
        x == '8' ||
        x == '9') {
      return true;
    } else {
      return false;
    }
  }

  bool isoperator(String x) {
    if (x == '*' || x == '+' || x == '-' || x == '/' || x == '=' || x == '%') {
      return true;
    } else {
      return false;
    }
  }

  Color changecolor(String c) {
    if (isoperator(c) == true) {
      return Colors.blue;
    } else if (c == 'Del') {
      return Colors.yellow;
    } else if (c == 'c') {
      return Colors.red;
    } else if (c == 'Ans') {
      return Colors.grey;
    }
  }

  Color inputcolor(String y) {
    if (isoperator(y) == true) {
      return Colors.blue;
    } else if (colornum(y) == true) {
      return Colors.deepPurple;
    } else if (y == 'Del') {
      return Colors.yellow;
    } else if (y == 'c') {
      return Colors.red;
    } else if (y == 'Ans') {
      return Colors.grey;
    }
  }

  void equalbutton() {
    Expression expression = Parser().parse(input);
    double endoutput = expression.evaluate(EvaluationType.REAL, ContextModel());
    setState(() {
      output = endoutput;
    });
  }
}
