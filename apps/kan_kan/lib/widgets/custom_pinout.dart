import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';
import 'package:ui/component/helper/custom_colors.dart';

class CustomPinput extends StatelessWidget {
  const CustomPinput({
    super.key,
    this.onCompleted,
  });
  final void Function(String)? onCompleted;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Pinput(
        length: 6,
        onCompleted: onCompleted,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        defaultPinTheme: PinTheme(
          width: 56,
          height: 56,
          textStyle: const TextStyle(
              fontSize: 20,
              color: AppColor.primary,
              fontWeight: FontWeight.w600),
          decoration: BoxDecoration(
            border: Border.all(color: AppColor.secondary),
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        focusedPinTheme: PinTheme(
          width: 56,
          height: 56,
          textStyle: const TextStyle(
              fontSize: 20,
              color: AppColor.primary,
              fontWeight: FontWeight.w600),
          decoration: BoxDecoration(
            border: Border.all(color: AppColor.secondary),
            borderRadius: BorderRadius.circular(50),
          ),
        ),
      ),
    );
  }
}
