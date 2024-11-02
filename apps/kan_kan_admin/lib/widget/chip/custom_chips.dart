import 'package:flutter/material.dart';
import 'package:helper/helper.dart';

class CustomChips extends StatelessWidget {
  const CustomChips({
    super.key,
    required this.status,
    this.onTap,
    this.statusColor,
  });
  final String status;
  final void Function()? onTap;
  final dynamic statusColor;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: MediaQuery.of(context).size.width * .09,
          height: MediaQuery.of(context).size.height * .05,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: getEnumColor(statusColor),
            ),
          ),
          child: Center(
            child: Text(
              style: TextStyle(
                  color: getEnumColor(statusColor),
                  fontWeight: FontWeight.bold),
              status,
            ),
          ),
        ),
      ),
    );
  }
}
