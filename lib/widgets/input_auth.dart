import 'package:flutter_coworkers/widgets/input_title.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class InputAuth extends StatelessWidget {
  const InputAuth({
    super.key,
    required this.hint,
    required this.editingController,
    required this.title,
  });
  final String title;
  final String hint;
  final TextEditingController editingController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InputTitle(x: title),
        Container(
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                blurRadius: 30,
                offset: const Offset(0, 6),
                color: const Color(0xffe5e7ec).withOpacity(0.5),
              ),
            ],
          ),
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TextField(
            controller: editingController,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(
                color: Color(0xffA7A8B3),
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(0),
              isDense: true,
            ),
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
