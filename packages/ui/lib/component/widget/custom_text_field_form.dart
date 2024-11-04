import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFieldForm extends StatelessWidget {
  const CustomTextFieldForm(
      {super.key,
      required this.title,
      this.icon,
      this.controller,
      this.onTap,
      this.readOnly = false,
      this.inputFormatters,
      this.validator,
      this.keyboardType, this.onChanged});
  final String title;
  final Widget? icon;
  final TextEditingController? controller;
  final Function()? onTap;
  final bool readOnly;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        onChanged: onChanged,
        scrollPadding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 50),
        validator: validator,
        readOnly: readOnly,
        inputFormatters: inputFormatters,
        onTap: onTap,
        controller: controller,
        keyboardType: keyboardType,
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
