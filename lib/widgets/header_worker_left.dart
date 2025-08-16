import 'package:flutter/material.dart';

class HeaderWorkerLeft extends StatelessWidget {
  const HeaderWorkerLeft({
    super.key,
    required this.title,
    required this.subtitle,
    required this.iconLeft,
    required this.functionLeft,
  });
  final String title;
  final String subtitle;
  final String iconLeft;
  final VoidCallback functionLeft;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          IconButton.filled(
            onPressed: functionLeft,
            icon: ImageIcon(AssetImage(iconLeft)),
            style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(
                Colors.white,
              ),
              foregroundColor: MaterialStatePropertyAll(
                Colors.black,
              ),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          const IconButton(
            onPressed: null,
            icon: Icon(
              Icons.abc,
              color: Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }
}
