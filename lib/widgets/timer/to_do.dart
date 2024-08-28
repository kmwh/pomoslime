import 'package:flutter/material.dart';
import 'package:pomoslime/provider/current_to_do_provider.dart';
import 'package:pomoslime/provider/timer_provider.dart';
import 'package:pomoslime/provider/to_do_list_provider.dart';
import 'package:provider/provider.dart';

class ToDo extends StatefulWidget {
  const ToDo({super.key});

  @override
  State<ToDo> createState() => _ToDoState();
}

void showToDoList(BuildContext context) {
  showModalBottomSheet(
    backgroundColor: Theme.of(context).colorScheme.surfaceBright,
    context: context,
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Icon(
                    Icons.add_circle_outline,
                    color: Theme.of(context).colorScheme.primary,
                    size: 22,
                  ),
                ),
                Text(
                  'To Do List',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.close,
                    color: Theme.of(context).colorScheme.primary,
                    size: 22,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 22),
            Expanded(
              child: SingleChildScrollView(
                child: Consumer<ToDoListProvider>(
                  builder: (context, provider, child) {
                    return GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: provider.toDoListLength,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // 한 줄에 2개의 아이템
                        mainAxisSpacing: 8, // 수직 간격
                        crossAxisSpacing: 12, // 수평 간격
                        childAspectRatio: 3, // 아이템의 가로 세로 비율
                      ),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            context
                                .read<CurrentToDoProvider>()
                                .setCurrentToDo(index);
                            context.read<TimerProvider>().onCancelPressed();
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 22,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0x00FFFFFF),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.circle,
                                  size: 10,
                                  color: Color(provider.toDoList[index][5]),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  provider.toDoList[index][0],
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}

class _ToDoState extends State<ToDo> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Consumer<CurrentToDoProvider>(
          builder: (context, toDoProvider, child) {
            return InkWell(
              onTap: () => showToDoList(context),
              child: Row(
                children: [
                  Consumer<TimerProvider>(
                    builder: (context, provider, child) {
                      return !provider.isRunning
                          ? Icon(
                              Icons.circle,
                              size: 10,
                              color: Color(toDoProvider.currentToDoColor),
                            )
                          : const SizedBox();
                    },
                  ),
                  const SizedBox(width: 6),
                  Text(
                    toDoProvider.currentToDoName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
