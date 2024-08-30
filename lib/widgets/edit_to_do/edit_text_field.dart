import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  const CustomTextField({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: (value) {},
      style: const TextStyle(
        fontWeight: FontWeight.w300,
      ),
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
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
        suffixIcon: const Icon(
          Icons.edit_square,
          color: Color.fromARGB(40, 255, 255, 255),
        ),
      ),
    );
  }
}
