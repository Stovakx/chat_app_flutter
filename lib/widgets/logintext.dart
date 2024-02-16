import 'package:flutter/material.dart';

class Logintext extends StatelessWidget {
  final void Function()? onTap;
  final String actionText;
  final String text;
  const Logintext({super.key, required this.text,  required this.actionText, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
        const SizedBox(width: 6),
        GestureDetector(
          onTap: onTap,
          child: Text(
            actionText,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary),
          ),
        ),
      ],
    );
  }
}
