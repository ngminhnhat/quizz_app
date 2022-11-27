import 'package:flutter/material.dart';

@immutable
class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    this.onPressed,
    required this.icon,
    required this.desscription,
  });

  final VoidCallback? onPressed;
  final Widget icon;
  final String desscription;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          child: Material(
            shape: const CircleBorder(),
            clipBehavior: Clip.antiAlias,
            color: theme.colorScheme.secondary,
            elevation: 4.0,
            child: IconButton(
              onPressed: onPressed,
              icon: icon,
              color: theme.colorScheme.onSecondary,
            ),
          ),
        ),
        Text(
          desscription,
          style: TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}
