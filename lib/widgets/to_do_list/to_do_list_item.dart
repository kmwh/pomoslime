import 'package:flutter/material.dart';
import 'package:pomoslime/provider/timer_provider.dart';
import 'package:pomoslime/provider/to_do_list_provider.dart';
import 'package:pomoslime/screens/edit_to_do_screen.dart';
import 'package:pomoslime/widgets/custom/custom_checkbox.dart';
import 'package:pomoslime/widgets/custom/custom_dialog.dart';
import 'package:provider/provider.dart';

class ToDoListItem extends StatefulWidget {
  final int index;

  const ToDoListItem({
    super.key,
    required this.index,
  });

  @override
  State<ToDoListItem> createState() => _ToDoListItemState();
}

class _ToDoListItemState extends State<ToDoListItem> {
  void showToDoDialog(int index) {
    if (index == context.read<ToDoListProvider>().currentToDo) {
      return;
    } else if (!context.read<TimerProvider>().isInit) {
      showDialog(
        context: context,
        builder: (context) {
          return CustomDialog(
            title: "세션 변경",
            content: "세션을 변경하면 현재 세션이 초기화됩니다.",
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

  void showDeleteDialog(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return CustomDialog(
          title: "세션 삭제",
          content: "삭제된 세션은 복구되지 않습니다",
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
              border: provider.currentToDo == widget.index
                  ? Border.all(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      width: 0.9,
                    )
                  : null,
              borderRadius: BorderRadius.circular(12),
            ),
            child: InkWell(
              onTap: () => showToDoDialog(widget.index),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CustomCheckbox(
                            value: provider.currentToDo == widget.index,
                            onChanged: (value) => showToDoDialog(widget.index),
                          ),
                          const SizedBox(width: 8),
                          Image.asset(
                            "assets/images/${provider.toDoList[widget.index]["icon"]}.png",
                            width: 20,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            provider.toDoList[widget.index]["name"],
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 18,
                              fontWeight: FontWeight.w300,
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
                                    index: widget.index,
                                    toDo: provider.toDoList[widget.index],
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
                            onPressed: provider.currentToDo != widget.index
                                ? () => showDeleteDialog(widget.index)
                                : null,
                            icon: Image.asset(
                              "assets/images/trash.png",
                              width: 26,
                              color: provider.currentToDo != widget.index
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
                      "${provider.toDoList[widget.index]["focusCount"].toString()}  |  ${provider.toDoList[widget.index]["focusTime"].toString()} min  |  ${provider.toDoList[widget.index]["shortBreakTime"].toString()} min  |  ${provider.toDoList[widget.index]["longBreakTime"].toString()} min",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        fontSize: 14,
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
