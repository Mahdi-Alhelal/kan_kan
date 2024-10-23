import 'package:flutter/material.dart';

class  CustomTextFieldForm extends StatelessWidget {
  const CustomTextFieldForm({super.key, required this.title, this.icon, this.controller});
  final String title;
  final Widget? icon;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: title,
          prefixIcon: icon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
