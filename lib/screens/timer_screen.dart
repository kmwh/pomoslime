import 'dart:async';

import 'package:flutter/material.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key});

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  int totalSeconds = 3;
  int totalPomodoros = 0;
  bool isRunning = false;
  late Timer timer;

  String workName = "pomodoro";

  void onTick(Timer timer) {
    if (totalSeconds == 0) {
      totalSeconds = 3;
      totalPomodoros += 1;
      debugPrint(totalPomodoros.toString());
    }
    setState(() {
      totalSeconds -= 1;
    });
  }

  void onStartPressed() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      onTick,
    );
    setState(() {
      isRunning = true;
    });
  }

  void onPausePressed() {
    timer.cancel();
    setState(() {
      isRunning = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          flex: 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: Image.asset(
                      height: 22,
                      "assets/images/todo.png",
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  Text(
                    workName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 18,
                ),
                child: Text(
                  "$totalSeconds",
                  style: const TextStyle(
                    fontSize: 70,
                    fontWeight: FontWeight.w100,
                  ),
                ),
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.circle,
                    size: 15,
                    color: Color.fromARGB(255, 229, 229, 229),
                  ),
                ],
              ),
            ],
          ),
        ),
        Flexible(
          flex: 1,
          child: Column(
            children: [
              const Icon(Icons.slideshow),
              IconButton(
                onPressed: isRunning ? onPausePressed : onStartPressed,
                icon: Image.asset(
                  height: 40,
                  isRunning
                      ? "assets/images/pause.png"
                      : "assets/images/play.png",
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
