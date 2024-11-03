import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kan_kan/cubit/home_cubit/home_cubit.dart';
import 'package:kan_kan/model/deal_model.dart';
import 'package:kan_kan/screens/home/deals_screen.dart';
import 'package:kan_kan/screens/home/profile_screen.dart';
import 'package:kan_kan/widgets/deal_card.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ui/ui.dart';

import 'deal_details_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: Builder(builder: (context) {
        final homeCubit = context.read<HomeCubit>();

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
                      child: homeCubit.userLayer.email != ""
                          ? ListTile(
                              leading: CircleAvatar(
                                backgroundColor:
                                    AppColor.black.withOpacity(20 / 100),
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
                                homeCubit.userLayer.user.fullName,
                                style: TextStyle(color: AppColor.secondary),
                              ),
                            )
                          : SizedBox()),
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
                  BlocBuilder<HomeCubit, HomeState>(
                    builder: (context, state) {
                      return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: homeCubit.dealLayer.deals.length,
                        itemBuilder: (BuildContext context, int index) {
                          return DealCard(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DealDetailsScreen(
                                            dealData: homeCubit
                                                .dealLayer.deals[index],
                                          )));
                            },
                            dealData: homeCubit.dealLayer.deals[index],
                            title: homeCubit.dealLayer.deals[index].dealTitle,
                            orderBooked:
                                homeCubit.dealLayer.deals[index].numberOfOrder,
                            orderMax: homeCubit.dealLayer.deals[index].quantity,
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
