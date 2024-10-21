import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

import 'deal_details_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: AppColor.black.withOpacity(20 / 100),
                  child: Icon(
                    Icons.person,
                    color: AppColor.white,
                  ),
                ),
                title: Text(
                  "مرحباً بعودتك ، 👋",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  "علي التاروتي",
                  style: TextStyle(color: AppColor.secondary),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: AppColor.primary,
                        borderRadius: BorderRadius.circular(8)),
                    width: 100,
                    height: 50,
                    alignment: Alignment.center,
                    child: Text(
                      "الأجهزة التقنية",
                      style: TextStyle(color: AppColor.white),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: AppColor.secondary,
                        borderRadius: BorderRadius.circular(8)),
                    width: 100,
                    height: 50,
                    alignment: Alignment.center,
                    child: Text(
                      "الأثاث",
                      style: TextStyle(color: AppColor.white),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: AppColor.primary,
                        borderRadius: BorderRadius.circular(8)),
                    width: 100,
                    height: 50,
                    alignment: Alignment.center,
                    child: Text(
                      "قريباً",
                      style: TextStyle(color: AppColor.white),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  DealCard(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const DealDetailsScreen()));
                    },
                  ),
                  DealCard(onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const DealDetailsScreen()));
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
