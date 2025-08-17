import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({super.key, required this.text, this.autoPadding = false});
  final String text;
  final bool autoPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: autoPadding
          ? const EdgeInsets.symmetric(horizontal: 20)
          : const EdgeInsets.all(0),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
    );
  }
}
