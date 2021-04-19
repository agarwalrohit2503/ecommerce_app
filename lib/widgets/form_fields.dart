import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  String title;
  bool isNotVisible;
  TextEditingController controller;

  CustomTextField({
    this.title,
    this.isNotVisible = false,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        obscureText: isNotVisible,
        decoration: InputDecoration(
          labelText: title,
        ),
      ),
    );
  }
}
