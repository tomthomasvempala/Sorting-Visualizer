import 'package:flutter/material.dart';
import 'dart:io';

class Bubble extends StatefulWidget {
  @override
  _BubbleState createState() => _BubbleState();
}

class _BubbleState extends State<Bubble> {
  int x1 = -1;
  int numberOfElements = 10;
  int x2 = -1;
  int time = 50;
  bool enabledShuff = true;
  List<double> listOfValues = [
    30,
    60,
    90,
    120,
    150,
    180,
    210,
    240,
    270,
    300,
    330,
  ];

  valueGenerator(int x) {
    listOfValues = [];
    for (int i = 0; i < x; i++) {
      listOfValues.add(10 + (350 / x) * i);
    }
    setState(() {});
  }

  void initState() {
    listOfValues.shuffle();
    super.initState();
  }

  Future<void> bubbleSort() async {
    for (x2 = 0; x2 < listOfValues.length; x2++) {
      for (x1 = 0; x1 < listOfValues.length - 1 - x2; x1++) {
        await Future.delayed(Duration(milliseconds: time), () {
          if (listOfValues[x1] > listOfValues[x1 + 1]) {
            double temp = listOfValues[x1];
            listOfValues[x1] = listOfValues[x1 + 1];
            listOfValues[x1 + 1] = temp;
          }
          setState(() {});
        });
      }
    }
    x1 = -1;
    setState(() {});
    enabledShuff = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bubble Sort"),
      ),
      body: Container(
          alignment: Alignment.bottomCenter,
          color: Colors.yellow,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  for (int i = 0; i < listOfValues.length; i++)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        color: (x1 == i || x1 + 1 == i) && x1 != -1
                            ? Colors.red
                            : i < listOfValues.length - x2
                                ? Colors.blue
                                : Colors.green,
                        width: (MediaQuery.of(context).size.width -
                                numberOfElements * 16) /
                            (numberOfElements + 2),
                        height: listOfValues[i],
                      ),
                    )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    OutlineButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        borderSide: BorderSide(width: 5),
                        onPressed: () async {
                          enabledShuff = false;
                          await bubbleSort();
                        },
                        child: Text(
                          "Sort",
                          style: TextStyle(fontSize: 50),
                        )),
                    OutlineButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        borderSide: BorderSide(width: 5),
                        onPressed: () async {
                          if (enabledShuff) {
                            listOfValues.shuffle();
                            x1 = -1;
                            x2 = -1;
                            setState(() {});
                          }
                        },
                        child: Text(
                          "Shuffle",
                          style: TextStyle(fontSize: 50),
                        )),
                  ],
                ),
              ),
              Slider(
                min: 10,
                max: 1000,
                value: time.toDouble(),
                onChanged: (v) {
                  time = v.toInt();
                  setState(() {});
                },
              ),
              Slider(
                divisions: 9,
                min: 5,
                max: 40,
                value: numberOfElements.toDouble(),
                onChanged: (v) {
                  if (enabledShuff) {
                    valueGenerator(v.floor());
                    numberOfElements = v.floor();
                    setState(() {});
                  }
                },
              )
            ],
          )),
    );
  }
}
