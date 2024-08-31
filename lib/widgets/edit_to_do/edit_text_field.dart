import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String, dynamic) onChanged;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: (value) => onChanged("name", value),
      style: const TextStyle(
        fontWeight: FontWeight.w300,
      ),
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primaryContainer,
            width: 0.8,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primaryContainer,
            width: 0.8,
          ),
        ),
        fillColor: Theme.of(context).colorScheme.surfaceBright,
        filled: true,
        hintText: "To Do",
        hintStyle: TextStyle(
          color: Theme.of(context).colorScheme.surfaceContainerLowest,
          fontWeight: FontWeight.w300,
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 12.0,
          horizontal: 12.0,
        ),
      ),
    );
  }
}
