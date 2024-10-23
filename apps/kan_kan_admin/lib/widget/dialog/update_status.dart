import 'package:flutter/material.dart';
import 'package:ui/component/widget/custom_drop_down_list.dart';

Future<void> updateStatus(
    {required BuildContext context,
    required String title,
  required void Function(dynamic) onChanged,
   required List<DropdownMenuItem<dynamic>> items,
    Widget? icon,
    void Function()? onPressed,
    required String value,
    }) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      content: CustomDropDownList(onChanged: onChanged, items: items,value: value,),
      
      actions: [TextButton(onPressed: onPressed, child: Text("تحديث"))],
    ),
  );
}

