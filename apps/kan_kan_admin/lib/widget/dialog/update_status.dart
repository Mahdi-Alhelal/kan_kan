import 'package:flutter/material.dart';
import 'package:ui/component/widget/custom_drop_down_menu.dart';

Future<void> updateStatus({
  required BuildContext context,
  required String title,
  required void Function(dynamic) onChanged,
  required List<DropdownMenuEntry<dynamic>> items,
  Widget? icon,
  void Function()? onPressed,
  required String value,
}) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      content: CustomDropDownMenu(
        hintText: "",
        dropdownMenuEntries: items,
        onSelected: onChanged,
      ),
      actions: [TextButton(onPressed: onPressed, child: const Text("تحديث"))],
    ),
  );
}
