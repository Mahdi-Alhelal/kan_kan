import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Column(
         children: [
          Text("text")
         ],
      ),
    );
  }
}