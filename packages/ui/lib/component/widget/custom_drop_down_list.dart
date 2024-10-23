
import 'package:flutter/material.dart';

class CustomDropDownList extends StatelessWidget {
  const CustomDropDownList(
      {super.key, required this.onChanged, required this.items});
  final void Function(dynamic)? onChanged;
  final List<DropdownMenuItem<dynamic>>? items;
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
        items: items,
        icon: const Icon(Icons.arrow_downward),
        elevation: 16,
        onChanged: onChanged);
  }
}