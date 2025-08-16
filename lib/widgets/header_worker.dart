import 'package:flutter/material.dart';

class HeaderWorker extends StatelessWidget {
  const HeaderWorker(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.iconLeft,
      required this.functionLeft,
      required this.iconRight,
      required this.functionRight});
  final String title;
  final String subtitle;
  final String iconLeft;
  final VoidCallback functionLeft;
  final String iconRight;
  final VoidCallback functionRight;

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
          IconButton.filled(
            onPressed: functionRight,
            icon: ImageIcon(AssetImage(iconRight)),
            style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(
                Colors.white,
              ),
              foregroundColor: MaterialStatePropertyAll(
                Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
