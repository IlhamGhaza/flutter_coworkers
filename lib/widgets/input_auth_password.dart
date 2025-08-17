import 'package:flutter/material.dart';
import 'package:flutter_coworkers/widgets/input_title.dart';

class InputAuthPassword extends StatefulWidget {
  const InputAuthPassword({
    super.key,
    required this.hint,
    required this.editingController,
    required this.title,
  });
  final String title;
  final String hint;
  final TextEditingController editingController;

  @override
  State<InputAuthPassword> createState() => _InputAuthPasswordState();
}

class _InputAuthPasswordState extends State<InputAuthPassword> {
  bool hide = true;
  void setHide() {
    hide = !hide;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InputTitle(x: widget.title),
        Container(
          height: 50,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                blurRadius: 30,
                offset: const Offset(0, 6),
                color: const Color(0xffe5e7ec).withValues(alpha: 0.5),
              ),
            ],
          ),
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 20, right: 8),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: widget.editingController,
                  obscureText: hide,
                  decoration: InputDecoration(
                    hintText: widget.hint,
                    hintStyle: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.all(0),
                    isDense: true,
                  ),
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              IconButton(
                onPressed: setHide,
                icon: ImageIcon(
                  AssetImage(
                    hide
                        ? 'assets/images/ic_eye_closed.png'
                        : 'assets/images/icon_eye_open.png',
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
