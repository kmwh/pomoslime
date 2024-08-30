import 'package:flutter/material.dart';

class ToDoScreen extends StatefulWidget {
  final int? index;
  final List? toDo;

  const ToDoScreen({
    super.key,
    this.index,
    this.toDo,
  });

  @override
  State<ToDoScreen> createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  TextEditingController titleController = TextEditingController();
  List newToDo = [];

  @override
  void initState() {
    super.initState();
    if (widget.toDo == null) {
      newToDo.addAll(["New To Do", 4, 1500, 300, 600, Colors.yellow.value]);
    } else {
      newToDo.addAll(widget.toDo!);
    }
    titleController.text = newToDo[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(
          widget.index == null ? "할 일 추가" : "할 일 편집",
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Image.asset(
            "assets/images/arrow_left.png",
            color: Theme.of(context).colorScheme.primary,
            width: 26,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 4,
        ),
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 250,
                  child: TextField(
                    controller: titleController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.note_alt_outlined),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 0.8,
                          color: Theme.of(context)
                              .colorScheme
                              .surfaceContainerLowest,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
