import 'package:flutter/material.dart';
import 'package:kan_kan_admin/widget/card/app_statistics.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            AppStatistics(
              icon: Icons.handshake_outlined,
              number: 5,
              type: "عدد الصفقات",
            ),
            AppStatistics(
              icon: Icons.factory,
              number: 1,
              type: "عدد المصانع",
            ),
            AppStatistics(
              icon: Icons.people_outline,
              number: 20,
              type: "عدد المسخدمين",
            ),
          ],
        )
      ],
    );
  }
}
