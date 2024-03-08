import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:to_do_list/ui/views/to_do_details/to_do_details_viewmodel.dart';

class BaseTimer extends StatefulWidget {
  int start;
  Function tapPlayButtonTap;
  void Function(int) tapStopButtonTap;

  BaseTimer({
    super.key,
    required this.start,
    required this.tapPlayButtonTap,
    required this.tapStopButtonTap,
  });

  @override
  State<BaseTimer> createState() => _BaseTimerState();
}

class _BaseTimerState extends State<BaseTimer> {
  Timer? timer;
  bool showPlayButton = true;

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

    setState(() {
      widget.tapPlayButtonTap.call();
      showPlayButton = false;
    });
  }

  void stopTimer() {
    timer?.cancel();
    setState(() {
      widget.tapStopButtonTap(widget.start--);
      showPlayButton = true;
    });
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
                onPressed: showPlayButton ? () => startTimer() : null,
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
                  'Play',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: showPlayButton ? null : () => stopTimer(),
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
