import 'package:flutter/material.dart';
import 'package:pomoslime/provider/to_do_list_provider.dart';
import 'package:pomoslime/screens/edit_to_do_screen.dart';
import 'package:pomoslime/widgets/to_do_list/to_do_list_item.dart';
import 'package:provider/provider.dart';

class ToDoListScreen extends StatefulWidget {
  const ToDoListScreen({super.key});

  @override
  State<ToDoListScreen> createState() => _ToDoListScreenState();
}

class _ToDoListScreenState extends State<ToDoListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: const Text(
          "To Do List",
          style: TextStyle(
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
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 6),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EditToDoScreen(),
                  ),
                );
              },
              icon: Image.asset(
                "assets/images/plus.png",
                width: 26,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ],
      ),
      body: Consumer<ToDoListProvider>(
        builder: (context, provider, child) {
          return SingleChildScrollView(
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: provider.toDoListLength,
              itemBuilder: (context, index) {
                return ToDoListItem(index: index);
              },
            ),
          );
        },
      ),
    );
  }
}
