import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pomoslime/provider/backup_provider.dart';
import 'package:pomoslime/provider/theme_provider.dart';
import 'package:pomoslime/provider/timer_provider.dart';
import 'package:pomoslime/provider/to_do_list_provider.dart';
import 'package:provider/provider.dart';

class TimerAnimations extends StatelessWidget {
  const TimerAnimations({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer4<ThemeProvider, TimerProvider, ToDoListProvider,
        BackupProvider>(
      builder: (context, themeProvider, timerProvider, toDoListProvider,
          backupProvider, child) {
        String animName = timerProvider.sessionName == 'focus'
            ? toDoListProvider.currentToDoMap['icon'] ?? 'book'
            : 'rest';
        return Lottie.asset(
          'assets/animations/slime_${animName}_${themeProvider.darkMode ? 'white' : 'black'}.json',
          animate: timerProvider.isRunning,
          width: 220,
        );
      },
    );
  }
}
