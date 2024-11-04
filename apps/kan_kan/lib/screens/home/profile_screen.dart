import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:kan_kan/cubit/profile_cubit/profile_cubit.dart';
import 'package:kan_kan/layer/user_data_layer.dart';
import 'package:ui/component/helper/screen.dart';
import 'package:ui/component/widget/custom_text_field.dart';
import 'package:ui/ui.dart';
import 'dart:ui' as ui;

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

        return Scaffold(
            appBar: AppBar(
              backgroundColor: AppColor.bg,
              title: Center(child: const Text("الملف الشخصي")),
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
                                      height: context.getHeight(value: 0.3),
                                      child: SingleChildScrollView(
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
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
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                CustomTextField(
                                                  title: "رقم الجوال",
                                                  controller: cubitProfile
                                                      .controllerPhone,
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                ElevatedButton(
                                                    onPressed: () async {
                                                      await cubitProfile
                                                          .updateEvent();
                                                    },
                                                    child: Text("حفظ"))
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
                                Icons.settings,
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
                            style: TextStyle(color: AppColor.secondary),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        BlocBuilder<ProfileCubit, ProfileState>(
                          builder: (context, state) {
                            CircularProgressIndicator(
                              color: AppColor.primary,
                            );

                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  width: context.getWidth(value: 0.3),
                                  height: context.getWidth(value: 0.2),
                                  decoration: BoxDecoration(
                                    color: AppColor.white,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "الصفقات الحالية",
                                        style: TextStyle(
                                            color: AppColor.secondary),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        cubitProfile.listOrdersNow.length
                                            .toString(),
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: context.getWidth(value: 0.3),
                                  height: context.getWidth(value: 0.2),
                                  decoration: BoxDecoration(
                                    color: AppColor.white,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "الصفقات السابقة",
                                        style: TextStyle(
                                            color: AppColor.secondary),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        cubitProfile.listPreviosOrders
                                            .toString(),
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.all(32.0),
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
                                        color: AppColor
                                            .primary, // Dark blue background for balance
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(8),
                                            bottomRight: Radius.circular(8)),
                                      ),
                                      child: Text(
                                        "${cubitProfile.userLayer.user.balance} ريال",
                                        style: TextStyle(
                                          color: AppColor.white,
                                          fontSize: 20,
                                        ),
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
                      ],
                    ),
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            onPressed: () {}, child: Text("يرجى تسجيل الدخول")),
                      ],
                    ),
                  ));
      }),
    );
  }
}
