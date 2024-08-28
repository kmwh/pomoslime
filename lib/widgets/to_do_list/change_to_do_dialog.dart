import 'package:flutter/material.dart';
import 'package:pomoslime/provider/timer_provider.dart';
import 'package:pomoslime/provider/to_do_list_provider.dart';
import 'package:provider/provider.dart';

class ChangeToDoDialog extends StatelessWidget {
  final int index;
  const ChangeToDoDialog({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.surfaceBright,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "세션 변경",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 15),
          const Text("세션을 변경하면 현재 세션이 초기화됩니다"),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton(
                onPressed: () {
                  context.read<ToDoListProvider>().setCurrentToDo(index);
                  context.read<TimerProvider>().onCancelPressed();
                  Navigator.pop(context);
                },
                style: const ButtonStyle(),
                child: const Text("확인"),
              ),
              const SizedBox(
                width: 10,
              ),
              OutlinedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: const ButtonStyle(),
                child: const Text("취소"),
              ),
            ],
          )
        ],
      ),
    );
  }
}
