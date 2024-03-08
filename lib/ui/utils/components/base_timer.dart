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
        Text(time),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () => startTimer(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF7C3AED),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Start',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () => stopTimer(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF7C3AED),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Stop',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () => resetTimer(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF7C3AED),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'reset',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
