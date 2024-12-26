import 'package:flutter/material.dart';

class BuildTextField extends StatelessWidget {
  const BuildTextField({
    super.key,
    required this.label,
    required this.prefix,
    required this.controller,
    required this.function,
  });

  final String label;
  final String prefix;
  final TextEditingController controller;
  final Function(String) function;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      cursorColor: Colors.amber,
      keyboardType: TextInputType.number,
      style: const TextStyle(
        color: Colors.amber,
        fontSize: 25.0,
      ),
      decoration: InputDecoration(
        labelText: label,
        prefixText: prefix,
        labelStyle: TextStyle(
          color: Colors.amber,
          fontSize: 25.0,
        ),
        prefixStyle: TextStyle(
          color: Colors.amber,
          fontSize: 25.0,
        ),
        border: OutlineInputBorder(),
      ),
    );
  }
}
