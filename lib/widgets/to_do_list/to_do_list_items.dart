import 'package:flutter/material.dart';
import 'package:pomoslime/provider/timer_provider.dart';
import 'package:pomoslime/provider/to_do_list_provider.dart';
import 'package:pomoslime/screens/to_do_screen.dart';
import 'package:pomoslime/widgets/to_do_list/change_to_do_dialog.dart';
import 'package:provider/provider.dart';

class ToDoListItems extends StatefulWidget {
  const ToDoListItems({super.key});

  @override
  State<ToDoListItems> createState() => _ToDoListItemsState();
}

class _ToDoListItemsState extends State<ToDoListItems> {
  void showToDoDialog(int index) {
    if (!context.read<TimerProvider>().isInit) {
      showDialog(
        context: context,
        builder: (context) {
          return ChangeToDoDialog(index: index);
        },
      );
    } else {
      context.read<ToDoListProvider>().setCurrentToDo(index);
      context.read<TimerProvider>().onCancelPressed();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Consumer<ToDoListProvider>(
        builder: (context, provider, child) {
          return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: provider.toDoListLength,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                child: InkWell(
                  onTap: () => showToDoDialog(index),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 14,
                      horizontal: 10,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 0.6,
                          color:
                              Theme.of(context).colorScheme.primaryContainer),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: provider.currentToDo == index,
                              onChanged: (value) {},
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              side: WidgetStateBorderSide.resolveWith(
                                (states) => BorderSide(
                                    width: 0.6,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .surfaceContainerLowest),
                              ),
                              checkColor: Colors.green,
                              activeColor: Colors.transparent,
                            ),
                            Icon(
                              Icons.circle,
                              size: 12,
                              color: Color(provider.toDoList[index][5]),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              provider.toDoList[index][0],
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Text(
                              "${provider.toDoList[index][1].toString()}  |  ${provider.toDoList[index][2].toString()}  |  ${provider.toDoList[index][3].toString()}",
                              style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ToDoScreen(
                                  index: index,
                                ),
                              ),
                            );
                          },
                          icon: Image.asset(
                            "assets/images/pencil.png",
                            width: 30,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
