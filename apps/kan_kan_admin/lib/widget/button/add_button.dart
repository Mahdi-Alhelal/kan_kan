import 'package:flutter/material.dart';
import 'package:ui/component/helper/screen.dart';

class AddButton extends StatelessWidget {
  const AddButton({
    super.key,
    this.onPressed,
  });
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.getWidth(value: 0.15),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(16),
            ),
          ),
        ),
        onPressed: onPressed,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [Icon(Icons.add), Text("إضافة")],
        ),
      ),
    );
  }
}
