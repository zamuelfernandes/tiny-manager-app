import 'package:flutter/material.dart';

class BaseTextField extends StatefulWidget {
  final String? labelText;
  final TextEditingController? controller;

  const BaseTextField({
    super.key,
    required this.labelText,
    required this.controller,
  });

  @override
  State<BaseTextField> createState() => _BaseTextFieldState();
}

class _BaseTextFieldState extends State<BaseTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      autocorrect: false,
      cursorColor: Colors.black,
      decoration: InputDecoration(
        labelText: widget.labelText,
        labelStyle: const TextStyle(fontSize: 14),
        floatingLabelStyle: const TextStyle(
          fontSize: 14,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100),
          borderSide: const BorderSide(
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
