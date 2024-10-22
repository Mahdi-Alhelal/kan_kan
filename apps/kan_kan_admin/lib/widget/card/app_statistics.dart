import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

class AppStatistics extends StatelessWidget {
  const AppStatistics({
    super.key,
    required this.type,
    required this.icon,
    required this.number,
  });
  final String type;
  final IconData icon;
  final int number;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        border: Border.all(color: AppColor.secondary),
        color: AppColor.white,
      ),
      height: MediaQuery.of(context).size.height * .15,
      width: MediaQuery.of(context).size.width * .15,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  icon,
                  color: AppColor.black,
                ),
                Text(
                  type,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
            Text(
              "$number",
              style: const TextStyle(fontSize: 20),
            )
          ],
        ),
      ),
    );
  }
}
