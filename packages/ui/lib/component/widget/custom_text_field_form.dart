import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFieldForm extends StatelessWidget {
  const CustomTextFieldForm(
      {super.key,
      required this.title,
      this.icon,
      this.controller,
      this.onTap,
      this.readOnly = false, this.inputFormatters});
  final String title;
  final Widget? icon;
  final TextEditingController? controller;
  final Function()? onTap;
  final bool readOnly;
  final List<TextInputFormatter>? inputFormatters;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        readOnly: readOnly,
        inputFormatters: inputFormatters,
        onTap: onTap,
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
