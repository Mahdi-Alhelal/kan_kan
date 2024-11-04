import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kan_kan/cubit/home_cubit/home_cubit.dart';
import 'package:kan_kan/model/deal_model.dart';
import 'package:kan_kan/screens/home/deals_screen.dart';
import 'package:kan_kan/screens/home/profile_screen.dart';
import 'package:kan_kan/widgets/custom_choice_chip.dart';
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
                  BlocBuilder<HomeCubit, HomeState>(
                    builder: (context, state) {
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: List.generate(
                                homeCubit.dealLayer.filterCategories.length,
                                (int index) {
                              return Row(
                                children: [
                                  CustomChoiceChip(
                                      title: homeCubit
                                              .dealLayer.filterCategories[index]
                                          ["category_name"],
                                      isSelected: homeCubit.dealLayer
                                                  .filterCategories[index]
                                              ["category_id"] ==
                                          homeCubit.initDeal,
                                      onSelected: (p0) {
                                        homeCubit.initDeal = homeCubit.dealLayer
                                                .filterCategories[index]
                                            ["category_id"];
                                        homeCubit.updateChipCategory();
                                        homeCubit.filterDeals(homeCubit
                                                .dealLayer
                                                .filterCategories[index]
                                            ["category_id"]);
                                      }),
                                  SizedBox(
                                    width: 20,
                                  )
                                ],
                              );
                            })),
                      );
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  BlocBuilder<HomeCubit, HomeState>(
                    builder: (context, state) {
              
                      return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: homeCubit.deals.length,
                        itemBuilder: (BuildContext context, int index) {
                    
                          return DealCard(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DealDetailsScreen(
                                            dealData: homeCubit.deals[index],
                                          )));
                            },
                            dealData: homeCubit.deals[index],
                            title: homeCubit.deals[index].dealTitle,
                            orderBooked: homeCubit.deals[index].numberOfOrder,
                            orderMax: homeCubit.deals[index].quantity,
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
