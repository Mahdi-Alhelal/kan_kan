import 'package:flutter/material.dart';

class CustomDropDownMenu extends StatelessWidget {
  const CustomDropDownMenu(
      {super.key,
      required this.dropdownMenuEntries,
      required this.hintText,
      this.onSelected});
  final List<DropdownMenuEntry<dynamic>> dropdownMenuEntries;
  final String hintText;
  final void Function(dynamic)? onSelected;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DropdownMenu(
        width: double.infinity,
        dropdownMenuEntries: dropdownMenuEntries,
        enableFilter: false,
        enableSearch: false,
        hintText: hintText,
        onSelected: onSelected,
      ),
    );
  }
}
