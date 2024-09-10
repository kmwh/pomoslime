import 'package:flutter/material.dart';
import 'package:pomoslime/widgets/edit_to_do/edit_icon_options.dart';

class EditIconButton extends StatelessWidget {
  final String currentIcon;
  final Function(String, dynamic) onTap;

  const EditIconButton({
    super.key,
    required this.currentIcon,
    required this.onTap,
  });

  void _showIconOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return EditIconOptions(
          currentIcon: currentIcon,
          onTap: onTap,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceBright,
        border: Border.all(
          color: Theme.of(context).colorScheme.primaryContainer,
          width: 0.8,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () => _showIconOptions(context),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Image.asset(
            "assets/images/$currentIcon.png",
            width: 20,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
