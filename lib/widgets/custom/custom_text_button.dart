import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final String text;
  final double width;
  final double fontSize;
  final double horizontalPadding;
  final double verticalPadding;
  final Function() onPressed;

  const CustomTextButton({
    super.key,
    required this.text,
    this.width = 104,
    this.fontSize = 14,
    required this.onPressed,
    this.horizontalPadding = 30,
    this.verticalPadding = 12,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          side: BorderSide(
            color: Theme.of(context).colorScheme.primaryContainer,
            width: 0.8,
          ),
          backgroundColor: Theme.of(context).colorScheme.surfaceBright,
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: verticalPadding,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w300,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
