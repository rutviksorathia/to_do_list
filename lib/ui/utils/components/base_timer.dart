import 'dart:async';

import 'package:flutter/material.dart';

class BaseTimer extends StatefulWidget {
  int start;

  BaseTimer({
    super.key,
    required this.start,
  });

  @override
  State<BaseTimer> createState() => _BaseTimerState();
}

class _BaseTimerState extends State<BaseTimer> {
  Timer? timer;

  String time = "";

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (widget.start == 0) {
          setState(() {
            timer.cancel();
            convertSecondToTime();
          });
        } else {
          setState(() {
            widget.start--;
            convertSecondToTime();
          });
        }
      },
    );
  }

  void stopTimer() {
    timer?.cancel();
    convertSecondToTime();
  }

  void resetTimer() {
    setState(() {
      widget.start;
      convertSecondToTime();
    });
  }

  void convertSecondToTime() {
    int min = (widget.start % 3600) ~/ 60;
    int sec = widget.start % 60;
    setState(() {
      time =
          "${min.toString().padLeft(2, '0')}:${sec.toString().padLeft(2, '0')}";
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ElevatedButton(
          onPressed: () {
            startTimer();
          },
          child: const Text("start"),
        ),
        ElevatedButton(
          onPressed: () {
            stopTimer();
          },
          child: const Text("stop"),
        ),
        ElevatedButton(
          onPressed: () {
            resetTimer();
          },
          child: const Text("reset"),
        ),
        Text(time.toString()),
      ],
    );
  }
}
