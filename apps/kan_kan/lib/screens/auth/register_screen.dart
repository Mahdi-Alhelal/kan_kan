import 'package:flutter/material.dart';
import 'package:kan_kan/screens/auth/Login_screen.dart';
import 'package:ui/component/helper/custom_colors.dart';
import 'package:ui/component/helper/screen.dart';
import 'package:ui/component/widget/custom_text_field.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: context.getHeight(value: 0.4),
              width: context.getWidth(),
              decoration: const BoxDecoration(
                color: AppColor.third,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Image.asset(
                    "assets/images/logo/kan_kan_logo.png",
                    width: context.getWidth(value: 0.75),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "التسجيل",
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 20,
            ),
             CustomTextField(
              title: "الإسم",
              icon: Icon(Icons.person),
            ),
             CustomTextField(
              title: "الإيميل",
              icon: Icon(Icons.email),
            ),
             CustomTextField(
              title: "رقم الجوال",
              icon: Icon(Icons.phone),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: context.getWidth(value: 0.5),
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    'التسجيل',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              child: const Text(
                'يوجد لديك حساب مسبقاً؟',
                style: TextStyle(
                  color: AppColor.secondary, // Light brown color for the text
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
