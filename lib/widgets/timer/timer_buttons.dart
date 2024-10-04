import 'package:flutter/material.dart';
import 'package:pomoslime/provider/backup_provider.dart';
import 'package:pomoslime/provider/timer_provider.dart';
import 'package:pomoslime/widgets/custom/custom_dialog.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class TimerButtons extends StatelessWidget {
  const TimerButtons({super.key});

  void showCancelDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return CustomDialog(
          title: "reset_session".tr(),
          content: "reset_session_description".tr(),
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
    return Consumer2<TimerProvider, BackupProvider>(
      builder: (context, provider, backupProvider, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: provider.isRunning
                  ? () => provider.onPausePressed(context)
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
