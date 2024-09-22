import 'package:flutter/material.dart';
import 'package:pomoslime/utils/ad_manager.dart';
import 'package:pomoslime/widgets/timer/timer.dart';
import 'package:pomoslime/widgets/timer/timer_animations.dart';
import 'package:pomoslime/widgets/timer/timer_buttons.dart';
import 'package:pomoslime/widgets/timer/timer_session.dart';
import 'package:pomoslime/widgets/timer/to_do.dart';

class TimerScreen extends StatelessWidget {
  const TimerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Flexible(
          flex: 13,
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
        const Flexible(
          flex: 13,
          child: Column(
            children: [
              TimerAnimations(),
              SizedBox(height: 20),
              TimerButtons(),
            ],
          ),
        ),
        Flexible(
          flex: 2,
          child: AdManager().getBannerAdWidget(0),
        ),
      ],
    );
  }
}
