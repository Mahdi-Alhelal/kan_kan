import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kan_kan/check_screen.dart';
import 'package:kan_kan/cubit/profile_cubit/profile_cubit.dart';
import 'package:kan_kan/screens/auth/login_screen.dart';
import 'package:kan_kan/screens/order_screen.dart';
import 'package:kan_kan/widgets/alert.dart';
import 'package:kan_kan/widgets/order_card.dart';
import 'package:lottie/lottie.dart';
import 'package:ui/component/helper/screen.dart';
import 'package:ui/component/widget/custom_text_field.dart';
import 'package:ui/ui.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(),
      child: Builder(builder: (context) {
        final cubitProfile = context.read<ProfileCubit>();
        if (cubitProfile.userLayer.email != "") {
          cubitProfile.controllerEmail.text =
              cubitProfile.userLayer.user.email.toString();
          cubitProfile.controllerPhone.text =
              cubitProfile.userLayer.user.phone.toString();
        }

        return BlocListener<ProfileCubit, ProfileState>(
          listener: (context, state) {
            if (state is LogOutSuccess) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const CheckScreen()),
                (Route<dynamic> route) => false,
              );
            }
          },
          child: Scaffold(
              appBar: AppBar(
                backgroundColor: AppColor.bg,
                title: const Center(
                  child: Text("الملف الشخصي"),
                ),
                actions: cubitProfile.userLayer.email.isNotEmpty
                    ? [
                        IconButton(
                          onPressed: () {
                            cubitProfile.logOutEvent();
                          },
                          icon: const Icon(Icons.logout_rounded),
                          color: Colors.red,
                        )
                      ]
                    : [],
              ),
              body: cubitProfile.userLayer.email != ""
                  ? SingleChildScrollView(
                      child: Column(
                        children: [
                          ListTile(
                            trailing: IconButton(
                                onPressed: () {
                                  showModalBottomSheet<void>(
                                    backgroundColor: AppColor.white,
                                    context: context,
                                    builder: (BuildContext context) {
                                      return SizedBox(
                                        height: context.getHeight(value: 0.4),
                                        child: SingleChildScrollView(
                                          child: Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: <Widget>[
                                                  CustomTextField(
                                                    title: "الإيميل",
                                                    readOnly: true,
                                                    controller: cubitProfile
                                                        .controllerEmail,
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  CustomTextField(
                                                    title: "رقم الجوال",
                                                    controller: cubitProfile
                                                        .controllerPhone,
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  ElevatedButton(
                                                      onPressed: () async {
                                                        await cubitProfile
                                                            .updateEvent();
                                                      },
                                                      child: const Text("حفظ"))
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                icon: const Icon(
                                  Icons.edit,
                                  color: AppColor.primary,
                                )),
                            leading: CircleAvatar(
                              backgroundColor:
                                  AppColor.black.withOpacity(20 / 100),
                              child: const Icon(
                                Icons.person,
                                color: AppColor.white,
                              ),
                            ),
                            title: const Text(
                              "مرحباً بعودتك ، 👋",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              cubitProfile.userLayer.user.fullName,
                              style: const TextStyle(color: AppColor.secondary),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          BlocConsumer<ProfileCubit, ProfileState>(
                            builder: (context, state) {
                              const CircularProgressIndicator(
                                color: AppColor.primary,
                              );

                              return Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: context.getWidth(value: 0.33),
                                      height: context.getWidth(value: 0.2),
                                      decoration: BoxDecoration(
                                        color: AppColor.white,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Text(
                                            "الصفقات الحالية",
                                            style: TextStyle(
                                                color: AppColor.secondary),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            cubitProfile.listOrdersNow.length
                                                .toString(),
                                            style:
                                                const TextStyle(fontSize: 18),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: context.getWidth(value: 0.33),
                                      height: context.getWidth(value: 0.2),
                                      decoration: BoxDecoration(
                                        color: AppColor.white,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Center(
                                            child: Text(
                                              "الصفقات السابقة",
                                              style: TextStyle(
                                                  color: AppColor.secondary),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            cubitProfile
                                                .listPreviosOrders.length
                                                .toString(),
                                            style:
                                                const TextStyle(fontSize: 18),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            listener:
                                (BuildContext context, ProfileState state) {
                              const CircularProgressIndicator(
                                color: AppColor.primary,
                              );
                              if (state is SuccessUpdateProfileState) {
                                alert(
                                    context: context,
                                    msg: "تم تحديث البيانات بنجاح",
                                    isCompleted: true);
                              }
                              if (state is ErrorProfileState) {
                                alert(
                                    context: context,
                                    msg: "يوجد خطأ في البيانات",
                                    isCompleted: false);
                              }
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColor.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    color: AppColor.secondary, width: 3),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      "رصيدك",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        width: context.getWidth(value: 0.75),
                                        alignment: Alignment.center,
                                        decoration: const BoxDecoration(
                                          color: AppColor.primary,
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(8),
                                              bottomRight: Radius.circular(8)),
                                        ),
                                        child: BlocBuilder<ProfileCubit,
                                            ProfileState>(
                                          builder: (context, state) {
                                            return Text(
                                              "${cubitProfile.userLayer.user.balance} ريال",
                                              style: const TextStyle(
                                                color: AppColor.white,
                                                fontSize: 20,
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Image.asset(
                                          "assets/images/logo/kan_kan_logo.png",
                                          width: context.getWidth(value: 0.3),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                ],
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Row(
                              children: [
                                Text("الطلبات الحالية"),
                              ],
                            ),
                          ),
                          BlocBuilder<ProfileCubit, ProfileState>(
                            builder: (context, state) {
                              return SizedBox(
                                height: context.getHeight(value: 0.30),
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount:
                                        cubitProfile.listOrdersNow.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return OrderCard(
                                        onPressed: () async {
                                          final x = await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    OrderScreen(
                                                      orderDetails: cubitProfile
                                                          .listOrdersNow[index],
                                                      dealDetails: cubitProfile
                                                          .userDeals
                                                          .findOldDeal(
                                                              cubitProfile
                                                                  .listOrdersNow[
                                                                      index]
                                                                  .dealId),
                                                    )),
                                          );
                                          if (x) {
                                            cubitProfile
                                                .listPreviosOrders[index]
                                                .orderStatus = "canceled";
                                            cubitProfile.cancelOrderByUser(
                                                index: index);
                                          }
                                        },
                                        dealDetails: cubitProfile.userDeals
                                            .findOldDeal(cubitProfile
                                                .listOrdersNow[index].dealId),
                                        orderDetails:
                                            cubitProfile.listOrdersNow[index],
                                      );
                                    }),
                              );
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Row(
                              children: [
                                Text("الطلبات السابقة"),
                              ],
                            ),
                          ),
                          BlocBuilder<ProfileCubit, ProfileState>(
                            builder: (context, state) {
                              return SizedBox(
                                height: context.getHeight(value: 0.30),
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount:
                                        cubitProfile.listPreviosOrders.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return OrderCard(
                                        onPressed: () async {
                                          await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    OrderScreen(
                                                      orderDetails: cubitProfile
                                                              .listPreviosOrders[
                                                          index],
                                                      dealDetails: cubitProfile
                                                          .userDeals
                                                          .findOldDeal(cubitProfile
                                                              .listPreviosOrders[
                                                                  index]
                                                              .dealId),
                                                    )),
                                          );
                                        },
                                        dealDetails: cubitProfile.userDeals
                                            .findOldDeal(cubitProfile
                                                .listPreviosOrders[index]
                                                .dealId),
                                        orderDetails: cubitProfile
                                            .listPreviosOrders[index],
                                      );
                                    }),
                              );
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    )
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Lottie.asset(
                            'assets/animation/profile.json',
                          ),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen()),
                                );
                              },
                              child: const Text("يرجى تسجيل الدخول")),
                        ],
                      ),
                    )),
        );
      }),
    );
  }
}
