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
              const Padding(
                padding: EdgeInsets.only(
                  top: 18,
                ),
                child: Text(
                  "25:00",
                  style: TextStyle(
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
                onPressed: () {},
                icon: Image.asset(
                  height: 40,
                  "assets/images/play.png",
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
