import 'package:flutter/material.dart';

class CustomDropDownList extends StatelessWidget {
  const CustomDropDownList(
      {super.key,
      required this.onChanged,
      required this.items,
      required this.value});
  final void Function(dynamic) onChanged;
  final List<DropdownMenuItem<dynamic>> items;
  final String value;
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
        items: items,
        alignment: Alignment.centerRight,
        value: value,
        icon: null,
        underline: null,
        elevation: 16,
        onChanged: onChanged);
  }
}
