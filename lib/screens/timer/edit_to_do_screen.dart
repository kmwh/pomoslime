import 'package:flutter/material.dart';
import 'package:pomoslime/provider/timer_provider.dart';
import 'package:pomoslime/provider/to_do_list_provider.dart';
import 'package:pomoslime/widgets/custom/custom_text_button.dart';
import 'package:pomoslime/widgets/edit_to_do/edit_content.dart';
import 'package:pomoslime/widgets/edit_to_do/edit_icon_button.dart';
import 'package:pomoslime/widgets/edit_to_do/edit_text_field.dart';
import 'package:pomoslime/widgets/custom/custom_dialog.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class EditToDoScreen extends StatefulWidget {
  final int? index;
  final Map? toDo;

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
  Map newToDo = {};

  @override
  void initState() {
    super.initState();
    if (widget.toDo == null) {
      newToDo = {
        "name": "Pomodoro",
        "focusCount": 4,
        "focusTime": 25,
        "shortBreakTime": 5,
        "longBreakTime": 10,
        "timeUnit": 5,
        "icon": "book"
      };
    } else {
      newToDo.addAll(widget.toDo!);
    }
    titleController = TextEditingController(text: newToDo["name"]);
  }

  void setNewToDoValue(String key, var value) {
    setState(() {
      newToDo[key] = value;
    });
  }

  void saveNewToDo() {
    if (widget.index == null) {
      context.read<ToDoListProvider>().addToDo(newToDo);
      Navigator.pop(context);
    } else if (widget.index == context.read<ToDoListProvider>().currentToDo &&
        !context.read<TimerProvider>().isInit) {
      showDialog(
        context: context,
        builder: (context) {
          return CustomDialog(
            title: "save_session_settings".tr(),
            content: "save_session_settings_description".tr(),
            onPressed: () {
              context
                  .read<ToDoListProvider>()
                  .updateToDo(widget.index!, newToDo);
              context.read<TimerProvider>().onCancelPressed();
              Navigator.pop(context);
              Navigator.pop(context);
            },
          );
        },
      );
    } else if (widget.index == context.read<ToDoListProvider>().currentToDo) {
      context.read<ToDoListProvider>().updateToDo(widget.index!, newToDo);
      context.read<TimerProvider>().onCancelPressed();
      Navigator.pop(context);
    } else {
      context.read<ToDoListProvider>().updateToDo(widget.index!, newToDo);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(
          widget.index == null ? "add_to_do".tr() : "edit_to_do".tr(),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  EditIconButton(
                    currentIcon: newToDo['icon'],
                    onTap: setNewToDoValue,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: SizedBox(
                      height: 48,
                      child: EditTextField(
                        controller: titleController,
                        onChanged: setNewToDoValue,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.only(
                  top: 6,
                  bottom: 6,
                  left: 10,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceBright,
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    width: 0.8,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    EditContent(
                      text: "focus_count".tr(),
                      timeUnit: 1,
                      currentValue: newToDo["focusCount"],
                      maxValue: 16,
                      minValue: 1,
                      toDoKey: "focusCount",
                      changeValueFunc: setNewToDoValue,
                    ),
                    EditContent(
                      text: "focus_time".tr(),
                      timeUnit: newToDo["timeUnit"],
                      currentValue: newToDo["focusTime"],
                      maxValue: 180,
                      minValue: 1,
                      toDoKey: "focusTime",
                      changeValueFunc: setNewToDoValue,
                      isMinute: true,
                    ),
                    EditContent(
                      text: "break_time".tr(),
                      timeUnit: newToDo["timeUnit"],
                      currentValue: newToDo["shortBreakTime"],
                      maxValue: 60,
                      minValue: 1,
                      toDoKey: "shortBreakTime",
                      changeValueFunc: setNewToDoValue,
                      isMinute: true,
                    ),
                    EditContent(
                      text: "long_break_time".tr(),
                      timeUnit: newToDo["timeUnit"],
                      currentValue: newToDo["longBreakTime"],
                      maxValue: 120,
                      minValue: 1,
                      toDoKey: "longBreakTime",
                      changeValueFunc: setNewToDoValue,
                      isMinute: true,
                    ),
                    EditContent(
                      text: "time_unit".tr(),
                      timeUnit: 4,
                      currentValue: newToDo["timeUnit"],
                      maxValue: 5,
                      minValue: 1,
                      toDoKey: "timeUnit",
                      changeValueFunc: setNewToDoValue,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTextButton(
                    text: "save".tr(),
                    onPressed: saveNewToDo,
                    verticalPadding: 16,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  CustomTextButton(
                    text: "cancel".tr(),
                    onPressed: () => Navigator.pop(context),
                    verticalPadding: 16,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
