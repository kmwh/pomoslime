import 'package:flutter/material.dart';
import 'package:pomoslime/widgets/timer/timer.dart';
import 'package:pomoslime/widgets/timer/timer_animations.dart';
import 'package:pomoslime/widgets/timer/timer_buttons.dart';
import 'package:pomoslime/widgets/timer/timer_session.dart';
import 'package:pomoslime/widgets/timer/to_do.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key});

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Flexible(
          flex: 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ToDo(),
              SizedBox(height: 18),
              Timer(),
              TimerSession(),
            ],
          ),
        ),
        Flexible(
          flex: 1,
          child: Column(
            children: [
              TimerAnimations(),
              SizedBox(height: 20),
              TimerButtons(),
            ],
          ),
        ),
      ],
    );
  }
}
