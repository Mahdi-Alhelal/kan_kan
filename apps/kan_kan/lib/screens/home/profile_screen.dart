import 'package:flutter/material.dart';
import 'package:ui/component/helper/screen.dart';
import 'package:ui/component/widget/custom_text_field.dart';
import 'package:ui/ui.dart';
import 'dart:ui' as ui;

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    TextEditingController controllerEmail = TextEditingController();
    TextEditingController controllerPhone = TextEditingController();

    controllerPhone.text = "0597555447";

    controllerEmail.text = "tarooti14@gmail.com";
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.bg,
        leading: const Icon(Icons.arrow_back),
        title: const Text("الملف الشخصي"),
      ),
      body: SingleChildScrollView(
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
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  CustomTextField(
                                    title: "الإيميل",
                                    readOnly: true,
                                    controller: controllerEmail,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  CustomTextField(
                                    title: "الإيميل",
                                    controller: controllerPhone,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  ElevatedButton(
                                      onPressed: () {}, child: Text("حفظ"))
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
              backgroundColor: AppColor.black.withOpacity(20 / 100),
              child: const Icon(
                Icons.person,
                color: AppColor.white,
              ),
            ),
            title: const Text(
              "مرحباً بعودتك ، 👋",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: const Text(
              "علي التاروتي",
              style: TextStyle(color: AppColor.secondary),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: context.getWidth(value: 0.3),
                height: context.getWidth(value: 0.2),
                decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "الصفقات الحالية",
                      style: TextStyle(color: AppColor.secondary),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "5",
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
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "الصفقات السابقة",
                      style: TextStyle(color: AppColor.secondary),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "5",
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: Container(
              decoration: BoxDecoration(
                color: AppColor.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColor.secondary, width: 3),
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
                        child: const Text(
                          "1500 ريال",
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
      )),
    );
  }
}
