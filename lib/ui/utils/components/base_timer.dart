import 'dart:async';

import 'package:flutter/material.dart';
import 'package:smooth_corner/smooth_corner.dart';
import 'package:to_do_list/ui/utils/extensions/p_utils.dart';
import 'package:to_do_list/ui/views/to_do_details/to_do_details_viewmodel.dart';

// ignore: must_be_immutable
class BaseTimer extends StatefulWidget {
  int start;
  ToDoStatus status;
  void Function(int) tapPlayButtonTap;
  void Function(int) tapStopButtonTap;
  void Function() tapFinishButtonTap;

  BaseTimer({
    super.key,
    required this.start,
    required this.status,
    required this.tapPlayButtonTap,
    required this.tapStopButtonTap,
    required this.tapFinishButtonTap,
  });

  @override
  State<BaseTimer> createState() => _BaseTimerState();
}

class _BaseTimerState extends State<BaseTimer> {
  Timer? timer;

  String? time;

  void startButton() {
    setState(() {
      playTimer();
    });
  }

  void playTimer() {
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (widget.start == 0) {
          setState(() {
            timer.cancel();
            convertSecondToTime();
            widget.tapPlayButtonTap.call(widget.start);
          });
        } else {
          setState(() {
            widget.start--;
            convertSecondToTime();
            widget.tapPlayButtonTap.call(widget.start);
          });
        }
      },
    );

    setState(() {
      widget.tapPlayButtonTap.call(widget.start);
    });
  }

  void pauseTimer() {
    timer?.cancel();
    setState(() {
      widget.tapStopButtonTap(widget.start--);
    });
    convertSecondToTime();
  }

  void stopTimer() {
    timer?.cancel();
    setState(() {
      widget.tapFinishButtonTap.call();
    });
  }

  void resetTimer() {
    setState(() {
      widget.start;
      convertSecondToTime();
    });
  }

  void convertSecondToTime() {
    setState(() {
      time = timeConverter(widget.start);
    });
  }

  @override
  void didUpdateWidget(covariant BaseTimer oldWidget) {
    widget.start = widget.start;
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.start);
    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(vertical: 18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (widget.status == ToDoStatus.created)
                ElevatedButton(
                  onPressed: () => startButton(),
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
              if (widget.status == ToDoStatus.inProgress &&
                  timer != null &&
                  !timer!.isActive)
                ElevatedButton(
                  onPressed: () => playTimer(),
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
              if (widget.status == ToDoStatus.inProgress &&
                  timer != null &&
                  timer!.isActive)
                ElevatedButton(
                  onPressed: () => pauseTimer(),
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
                    'Pause',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              Container(
                decoration: ShapeDecoration(
                  shape: SmoothRectangleBorder(
                    smoothness: 1.0,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: Colors.grey[200],
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text(
                    time != null ? '$time' : timeConverter(widget.start),
                    style: const TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
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
                  'Finish',
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
