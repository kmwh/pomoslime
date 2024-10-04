import 'package:flutter/material.dart';
import 'package:pomoslime/provider/backup_provider.dart';
import 'package:pomoslime/provider/timer_provider.dart';
import 'package:pomoslime/provider/to_do_list_provider.dart';
import 'package:pomoslime/screens/timer/to_do_list_screen.dart';
import 'package:provider/provider.dart';

class ToDo extends StatelessWidget {
  const ToDo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Consumer2<ToDoListProvider, BackupProvider>(
          builder: (context, toDoProvider, backupProvider, child) {
            return Consumer<TimerProvider>(
              builder: (context, provider, child) {
                return GestureDetector(
                  onTap: () => {
                    !provider.isRunning
                        ? Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ToDoListScreen(),
                            ),
                          )
                        : null,
                  },
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/images/${toDoProvider.toDoList[toDoProvider.currentToDo]["icon"]}.png",
                        width: 20,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        toDoProvider.currentToDoMap['name'],
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w100,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}
