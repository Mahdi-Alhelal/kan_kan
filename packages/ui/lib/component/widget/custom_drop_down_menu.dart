import 'package:flutter/material.dart';
import 'package:ui/component/helper/custom_colors.dart';

class CustomDropDownMenu extends StatelessWidget {
  const CustomDropDownMenu({
    super.key,
    required this.dropdownMenuEntries,
    required this.hintText,
    this.onSelected,
    this.errorText,
  });
  final List<DropdownMenuEntry<dynamic>> dropdownMenuEntries;
  final String hintText;
  final void Function(dynamic)? onSelected;
  final String? errorText;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DropdownMenu(
        errorText: errorText,
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

class CustomDropDownButton extends StatelessWidget {
  const CustomDropDownButton(
      {super.key,
      required this.items,
      this.onChanged,
      this.validator,
      this.hint,
      this.value});
  final List<DropdownMenuItem<dynamic>> items;
  final void Function(dynamic)? onChanged;
  final String? Function(dynamic)? validator;
  final Widget? hint;
  final dynamic value;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: DropdownButtonFormField(
        decoration: const InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        ),
        hint: hint,
        
        items: items,
        value: value,
        onChanged: onChanged,
        validator: validator,
        dropdownColor: AppColor.white,
      ),
    );
  }
}
