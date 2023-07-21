import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class stopwatch extends StatefulWidget {
  const stopwatch({super.key});

  @override
  State<stopwatch> createState() => _stopwatchState();
}

class _stopwatchState extends State<stopwatch> {
  String hoursString = "00", minutsString = "00", secondString = "00";

  int hours = 0, minuts = 0, seconds = 0;
  bool timerRun = false;
  late Timer _timer;

  void starttimer() {
    setState(() {
      timerRun = true;
    });
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _startsecond();
    });
  }

  void pausetimer() {
    _timer.cancel();
    setState(() {
      timerRun = false;
    });
  }

  void _startsecond() {
    setState(() {
      if (seconds < 59) {
        seconds++;
        secondString = seconds.toString();
        if (secondString.length == 1) {
          secondString = "0" + secondString;
        }
      } else {
        _startminuts();
      }
    });
  }

  void _startminuts() {
    setState(() {
      if (minuts < 59) {
        seconds = 0;
        secondString = "00";
        minuts++;
        minutsString = minuts.toString();
        if (minutsString.length == 1) {
          minutsString = "0" + minutsString;
        }
      } else {
        _starthours();
      }
    });
  }

  void _starthours() {
    setState(() {
      seconds = 0;
      minuts = 0;
      secondString = "00";
      minutsString = "00";
      hours++;
      hoursString = hours.toString();
      if (hoursString.length == 1) {
        hoursString = "0" + hoursString;
      }
    });
  }

  void resettimer() {
    _timer.cancel();
    setState(() {
      seconds = 0;
      minuts = 0;
      hours = 0;
      secondString = "00";
      minutsString = "00";
      hoursString = "00";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff00152A),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xff00152A)),
                    child: Center(
                      child: Text(
                        '$hoursString:$minutsString:$secondString',
                        style: TextStyle(fontSize: 70, color: Colors.white),
                      ),
                    )),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                      resettimer();
                    },
                    child: Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.blueGrey,
                      ),
                      child: Center(
                          child: Text(
                        "Reset",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      )),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      if (timerRun) {
                        pausetimer();
                      } else {
                        starttimer();
                      }
                    },
                    child: Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.teal,
                      ),
                      child: Center(
                        child: Text(
                          timerRun ? "Pause" : "Start",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ));
  }
}
