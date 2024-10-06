import 'package:flutter/material.dart';
import 'package:pomoslime/provider/timer_provider.dart';
import 'package:pomoslime/provider/to_do_list_provider.dart';
import 'package:pomoslime/screens/timer/edit_to_do_screen.dart';
import 'package:pomoslime/widgets/custom/custom_checkbox.dart';
import 'package:pomoslime/widgets/custom/custom_dialog.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class ToDoListItem extends StatelessWidget {
  final int index;

  const ToDoListItem({
    super.key,
    required this.index,
  });

  void showToDoDialog(BuildContext context, int index) {
    if (index == context.read<ToDoListProvider>().currentToDo) {
      return;
    } else if (!context.read<TimerProvider>().isInit) {
      showDialog(
        context: context,
        builder: (context) {
          return CustomDialog(
            title: "change_to_do".tr(),
            content: "change_to_do_description".tr(),
            onPressed: () {
              context.read<ToDoListProvider>().setCurrentToDo(index);
              context.read<TimerProvider>().onCancelPressed();
              Navigator.pop(context);
            },
          );
        },
      );
    } else {
      context.read<ToDoListProvider>().setCurrentToDo(index);
      context.read<TimerProvider>().onCancelPressed();
    }
  }

  void showDeleteDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (context) {
        return CustomDialog(
          title: "delete_to_do".tr(),
          content: "delete_to_do_description".tr(),
          onPressed: () {
            context.read<ToDoListProvider>().deleteToDo(index);
            Navigator.pop(context);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 4,
      ),
      child: Consumer<ToDoListProvider>(
        builder: (context, provider, child) {
          return Container(
            padding: const EdgeInsets.symmetric(
              vertical: 14,
              horizontal: 10,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceBright,
              border: provider.currentToDo == index
                  ? Border.all(
                      color: Theme.of(context)
                          .colorScheme
                          .primaryContainer
                          .withOpacity(0.5),
                    )
                  : null,
              borderRadius: BorderRadius.circular(12),
            ),
            child: InkWell(
              onTap: () => showToDoDialog(context, index),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CustomCheckbox(
                            value: provider.currentToDo == index,
                            onChanged: (value) =>
                                showToDoDialog(context, index),
                          ),
                          const SizedBox(width: 8),
                          Image.asset(
                            "assets/images/${provider.toDoList[index]["icon"]}.png",
                            width: 20,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            provider.toDoList[index]["name"],
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 18,
                              fontWeight: FontWeight.w200,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditToDoScreen(
                                    index: index,
                                    toDo: provider.toDoList[index],
                                  ),
                                ),
                              );
                            },
                            icon: Image.asset(
                              "assets/images/pencil.png",
                              width: 26,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          IconButton(
                            onPressed: provider.currentToDo != index
                                ? () => showDeleteDialog(context, index)
                                : null,
                            icon: Image.asset(
                              "assets/images/trash.png",
                              width: 26,
                              color: provider.currentToDo != index
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context)
                                      .colorScheme
                                      .surfaceContainerLowest,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 46),
                    child: Text(
                      "${provider.toDoList[index]["focusCount"].toString()}  |  ${provider.toDoList[index]["focusTime"].toString()} min  |  ${provider.toDoList[index]["shortBreakTime"].toString()} min  |  ${provider.toDoList[index]["longBreakTime"].toString()} min",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
