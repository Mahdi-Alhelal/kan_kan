import 'package:flutter/material.dart';
import 'package:ui/component/helper/screen.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
   required this.onPressed,
    required this.text,
  });
  final String text;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.getWidth(value: 0.75),
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
          ),
        ),
        onPressed: onPressed,
        child: Text(text),
      ),
    );
  }
}
