import 'package:flutter/material.dart';
import 'package:pomoslime/widgets/edit_to_do/edit_text_field.dart';

class EditToDoScreen extends StatefulWidget {
  final int? index;
  final List? toDo;

  const EditToDoScreen({
    super.key,
    this.index,
    this.toDo,
  });

  @override
  State<EditToDoScreen> createState() => _EditToDoScreenState();
}

class _EditToDoScreenState extends State<EditToDoScreen> {
  TextEditingController titleController = TextEditingController();
  List newToDo = [];

  @override
  void initState() {
    super.initState();
    if (widget.toDo == null) {
      newToDo.addAll(["New To Do", 4, 1500, 300, 600, "pencil"]);
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
          widget.index == null ? "Add To Do" : "Edit To Do",
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w300,
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
          vertical: 20,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 48,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceBright,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: InkWell(
                      onTap: () {},
                      child: Image.asset(
                        "assets/images/${newToDo[5]}.png",
                        width: 20,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: SizedBox(
                    height: 48,
                    child: CustomTextField(controller: titleController),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 6,
            ),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceBright,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Column(
                children: [
                  Row(
                    children: [
                      Text("data"),
                    ],
                  ),
                  Row(
                    children: [
                      Text("data"),
                    ],
                  ),
                  Row(
                    children: [
                      Text("data"),
                    ],
                  ),
                  Row(
                    children: [
                      Text("data"),
                    ],
                  ),
                  Row(
                    children: [
                      Text("data"),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
