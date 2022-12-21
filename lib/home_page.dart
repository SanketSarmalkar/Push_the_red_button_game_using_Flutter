import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'dart:math';
import 'dart:async';

//used hive
//https://mightytechno.com/how-to-use-timer-and-periodic-in-flutter/#:~:text=If%20you%20need%20to%20execute%20a%20piece%20of,period%20code%20will%20be%20executed%20inside%20the%20Timer.
//https://www.kindacode.com/article/flutter-timer/

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // reference our box
  final _myBox = Hive.box("mybox");
  Color k = Colors.red;
  var highScore = 0;
  var start = false;
  var currScore = 0;

  // write data
  // void writeData() {
  //   //_myBox.put(1,'sanket');
  //   _myBox.put(4, 'mohan');
  //   print(_myBox.get(1));
  //   print(_myBox.values);
  // }

  bool RandomNum() {
    Random random = new Random();
    return random.nextBool();
  }

  // read Data
  // void readData() {
  //   print(_myBox.get(1));
  // }

  void startTimer() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (start == false) {
        timer.cancel();
      }
      setState(() {
        k = RandomNum() ? Colors.red : Colors.blue;
        print(k);
      });
    });
  }

  // deleteData
  void deleteData() {
    _myBox.delete(1);
    print(_myBox.values);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: SizedBox(height: 5),
                  ),
                  Expanded(
                      flex: 8,
                      child: Container(
                        child: Center(child: Text("Click The Red Button")),
                        decoration: BoxDecoration(
                          color: Colors.deepPurpleAccent,
                        ),
                      )),
                ],
              ),
            ),
            Expanded(
              flex: 9,
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('High Score'),
                          Text((_myBox.get(1) == null)
                              ? "0"
                              : _myBox.get(1).toString())
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        if (k == Colors.red) {
                          setState(() {
                            currScore++;
                          });
                        } else {
                          _myBox.put(
                              1,
                              (_myBox.get(1) == null)
                                  ? 0
                                  : (_myBox.get(1) < currScore)
                                      ? currScore
                                      : _myBox.get(1));
                          currScore = 0;
                          start = false;
                        }
                      },
                      child: Container(
                        child: Center(child: Text("click")),
                        color: k,
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                        onTap: () {
                          setState(() {
                            start = true;
                          });
                          startTimer();
                        },
                        child: Container(
                          child: Center(child: Text("start")),
                          color: Colors.purple,
                        )),
                  ),
                  Expanded(
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            child: Text('score'),
                          ),
                          Container(
                            child: Text(currScore.toString()),
                          ),
                        ],
                      ),
                    ),
                  ),
                  //   MaterialButton(onPressed: deleteData,
                  //   color: Colors.deepPurpleAccent,)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
