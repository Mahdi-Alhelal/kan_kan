import 'package:flutter/material.dart';
import 'package:kan_kan/screens/home/profile_screen.dart';
import 'package:ui/component/helper/screen.dart';
import 'package:ui/ui.dart';

import 'deal_details_screen.dart';

class DealsScreen extends StatelessWidget {
  const DealsScreen({super.key});

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
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProfileScreen()));
                },
                child: ListTile(
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
                    width: context.getWidth(value: 0.45),
                    height: 50,
                    alignment: Alignment.center,
                    child: Text(
                      "الصفقات الحالية",
                      style: TextStyle(color: AppColor.white),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: AppColor.secondary,
                        borderRadius: BorderRadius.circular(8)),
                    width: context.getWidth(value: 0.45),
                    height: 50,
                    alignment: Alignment.center,
                    child: Text(
                      "الصفقات السابقة",
                      style: TextStyle(color: AppColor.white),
                    ),
                  ),
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
