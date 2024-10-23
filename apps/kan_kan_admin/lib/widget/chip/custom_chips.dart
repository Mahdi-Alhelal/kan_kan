import 'package:flutter/material.dart';
import 'package:kan_kan_admin/helper/status_color.dart';

class CustomChips extends StatelessWidget {
  const CustomChips({
    super.key,
    required this.status,
    this.onTap,
  });
  final String status;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: MediaQuery.of(context).size.width * .07,
          height: MediaQuery.of(context).size.height * .05,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: statusColors(status: status),
            ),
          ),
          child: Center(
            child: Text(
              style: TextStyle(
                  color: statusColors(status: status),
                  fontWeight: FontWeight.bold),
              status,
            ),
          ),
        ),
      ),
    );
  }
}
