import 'package:flutter/material.dart';
import 'package:pomoslime/provider/timer_provider.dart';
import 'package:pomoslime/provider/to_do_list_provider.dart';
import 'package:pomoslime/screens/to_do_screen.dart';
import 'package:pomoslime/widgets/to_do/custom_checkbox.dart';
import 'package:pomoslime/widgets/to_do/custom_dialog.dart';
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
            index: index,
            func: () {
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
          index: index,
          func: () {
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
        horizontal: 8,
        vertical: 4,
      ),
      child: InkWell(
        onTap: () => showToDoDialog(widget.index),
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 14,
            horizontal: 10,
          ),
          decoration: BoxDecoration(
            border: Border.all(
                width: 0.8,
                color: Theme.of(context).colorScheme.surfaceContainerLowest),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Consumer<ToDoListProvider>(
            builder: (context, provider, child) {
              return Column(
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
                          Icon(
                            Icons.circle,
                            size: 12,
                            color: Color(provider.toDoList[widget.index][5]),
                          ),
                          const SizedBox(width: 14),
                          Text(
                            provider.toDoList[widget.index][0],
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(width: 16),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ToDoScreen(
                                    index: widget.index,
                                    toDo:
                                        provider.toDoList[provider.currentToDo],
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
                            onPressed: () => showDeleteDialog(widget.index),
                            icon: const Icon(Icons.delete_outline_outlined),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 46),
                    child: Text(
                      "${provider.toDoList[widget.index][1].toString()}  |  ${provider.toDoList[widget.index][2].toString()}0 min  |  ${provider.toDoList[widget.index][3].toString()}00 min  |  ${provider.toDoList[widget.index][4].toString()}0 min",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
