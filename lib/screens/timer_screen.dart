import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pomoslime/provider/current_to_do_provider.dart';
import 'package:pomoslime/provider/theme_provider.dart';
import 'package:pomoslime/provider/timer_provider.dart';
import 'package:pomoslime/widgets/timer/timer_session.dart';
import 'package:provider/provider.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key});

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TimerProvider>(
      builder: (context, provider, child) {
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
                      Consumer<CurrentToDoProvider>(
                        builder: (context, toDoProvider, child) {
                          return Text(
                            toDoProvider.currentToDo[0],
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 18,
                    ),
                    child: Text(
                      provider.formattedCurrentSessionSeconds,
                      style: const TextStyle(
                        fontSize: 70,
                        fontWeight: FontWeight.w100,
                      ),
                    ),
                  ),
                  const TimerSession(),
                ],
              ),
            ),
            Flexible(
              flex: 1,
              child: Column(
                children: [
                  Lottie.asset(
                    'assets/animations/slime_book_${context.read<ThemeProvider>().darkMode ? 'white' : 'black'}.json',
                    animate: provider.isRunning,
                    width: 220,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: provider.isRunning
                            ? provider.onPausePressed
                            : provider.onStartPressed,
                        icon: Image.asset(
                          height: 40,
                          provider.isRunning
                              ? "assets/images/pause.png"
                              : "assets/images/play.png",
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      const SizedBox(
                        width: 14,
                        height: 0,
                      ),
                      (!provider.isRunning && !provider.isInit)
                          ? IconButton(
                              onPressed:
                                  context.read<TimerProvider>().onCancelPressed,
                              icon: Image.asset(
                                height: 40,
                                "assets/images/cancel.png",
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            )
                          : const SizedBox(),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
