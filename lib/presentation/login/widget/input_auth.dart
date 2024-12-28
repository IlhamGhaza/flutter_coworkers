import 'package:flutter/material.dart';

class InputAuth extends StatefulWidget {
  final TextEditingController editingController;
  final String labelText;
  final TextInputType keyboardType;
  final bool obscureText;
  final IconData prefixIcon;
  final String? Function(String?)? validator; 
  final TextEditingController? confirmPasswordController;

  const InputAuth({
    Key? key,
    required this.editingController,
    required this.labelText,
    required this.keyboardType,
    required this.obscureText,
    required this.prefixIcon,
    this.validator,
    this.confirmPasswordController,
  }) : super(key: key);

  @override
  State<InputAuth> createState() => _InputAuthState();
}

class _InputAuthState extends State<InputAuth> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Color(0xffe5e7ac).withOpacity(0.5),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: TextFormField(
        controller: widget.editingController,
        keyboardType: widget.keyboardType,
        obscureText: _obscureText,
        validator: widget.validator ?? _defaultValidator,
        decoration: InputDecoration(
          labelText: widget.labelText,
          labelStyle: TextStyle(color: Color(0xffa7a8b3)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          prefixIcon: Icon(widget.prefixIcon, color: Color(0xff4e40f6)),
          suffixIcon: widget.obscureText
              ? IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                    color: Color(0xff4e40f6),
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                )
              : null,
        ),
        style: TextStyle(color: Color(0xff13162f)),
        cursorColor: Color(0xff4e40f6),
      ),
    );
  }

  String? _defaultValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field cannot be empty';
    }
    if (widget.confirmPasswordController != null) {
      if (value != widget.confirmPasswordController!.text) {
        return 'Passwords do not match';
      }
    }
    return null;
  }
}
