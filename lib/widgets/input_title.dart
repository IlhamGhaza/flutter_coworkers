import 'package:flutter/material.dart';

class InputTitle extends StatelessWidget {
  const InputTitle({super.key, required this.x});
  final String x;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 8,
      ),
      child: Text(
        x,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Colors.black,
        ),
      ),
    );
  }
}
