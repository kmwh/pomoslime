import 'package:flutter/material.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key});

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  String workName = "pomodoro";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          flex: 5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.list),
                  Text(workName),
                ],
              ),
              const Text(
                "25:00",
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 50,
                ),
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.circle,
                    size: 15,
                    color: Colors.grey,
                  ),
                ],
              ),
            ],
          ),
        ),
        Flexible(
          flex: 6,
          child: Column(
            children: [
              const Icon(Icons.slideshow),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.play_arrow_outlined),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
