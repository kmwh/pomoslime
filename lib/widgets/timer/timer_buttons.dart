import 'package:flutter/material.dart';
import 'package:pomoslime/provider/timer_provider.dart';
import 'package:pomoslime/widgets/custom/custom_dialog.dart';
import 'package:provider/provider.dart';

class TimerButtons extends StatelessWidget {
  const TimerButtons({super.key});

  void showCancelDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return CustomDialog(
          title: "세션 초기화",
          content: "세션을 초기화하면 이전 과정까지 기록됩니다",
          onPressed: () {
            context.read<TimerProvider>().onCancelPressed();
            Navigator.pop(context);
          },
        );
      },
    );
  }

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
                  ? () => provider.onPausePressed()
                  : () => provider.onStartPressed(context),
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
                    onPressed: () => showCancelDialog(context),
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
