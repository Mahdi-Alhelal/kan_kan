import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

class CustomSelectedIcon extends StatelessWidget {
  const CustomSelectedIcon({
    super.key,
    required this.text,
    required this.icon,
  });
  final String text;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: MediaQuery.of(context).size.width * .1,
      height: MediaQuery.of(context).size.height * .05,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(10),
        color: AppColor.primary,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(
            icon,
            color: AppColor.white,
          ),
          Text(
            text,
            style: const TextStyle(color: AppColor.white),
          ),
        ],
      ),
    );
  }
}
