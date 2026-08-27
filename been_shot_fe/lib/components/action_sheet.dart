import 'package:flutter/material.dart';

class ActionSheet extends StatelessWidget {
  const ActionSheet({
    required this.actions,
    super.key,
  });

  final List<ActionItem> actions;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 300),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: actions,
        ),
      ),
    );
  }
}

class ActionItem extends StatelessWidget {
  const ActionItem({
    required this.icon,
    required this.text,
    this.onTap,
    super.key,
  });

  final IconData icon;
  final String text;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.zero,
      child: ListTile(
        leading: Icon(icon, size: 32),
        title: Text(
          text,
          style: const TextStyle(fontSize: 20),
        ),
        onTap: () {
          Navigator.pop(context);
          onTap?.call();
        },
      ),
    );
  }
}