import 'package:flutter/material.dart';
import 'package:pomoslime/provider/timer_provider.dart';
import 'package:provider/provider.dart';

class TimerButtons extends StatelessWidget {
  const TimerButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TimerProvider>(
      builder: (context, provider, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: provider.isRunning
                  ? provider.onPausePressed
                  : provider.onStartPressed,
              icon: Image.asset(
                height: 32,
                provider.isRunning
                    ? "assets/images/pause.png"
                    : "assets/images/play.png",
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(
              width: 10,
              height: 0,
            ),
            (!provider.isRunning && !provider.isInit)
                ? IconButton(
                    onPressed: provider.onCancelPressed,
                    icon: Image.asset(
                      height: 32,
                      "assets/images/cancel.png",
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  )
                : const SizedBox(),
          ],
        );
      },
    );
  }
}
