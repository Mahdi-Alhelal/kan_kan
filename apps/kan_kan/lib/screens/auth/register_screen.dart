import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kan_kan/cubit/auth_cubit/auth_cubit.dart';
import 'package:kan_kan/screens/auth/Login_screen.dart';
import 'package:kan_kan/screens/auth/auth_srceen.dart';
import 'package:ui/component/helper/custom_colors.dart';
import 'package:ui/component/helper/screen.dart';
import 'package:ui/component/widget/custom_text_field_form.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Builder(builder: (context) {
        final cubitAuth = context.read<AuthCubit>();
        return Form(
          key: formKey,
          child: Scaffold(
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
                  const Text(
                    "التسجيل",
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextFieldForm(
                    title: "الإسم",
                    controller: cubitAuth.fullController,
                    icon: const Icon(Icons.person),
                    validator: (value) =>
                        value == null || value.isEmpty ? "اسم مطلوب" : null,
                  ),
                  CustomTextFieldForm(
                    title: "الإيميل",
                    controller: cubitAuth.emailController,
                    icon: const Icon(Icons.email),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "بريد مطلوب";
                      }
                      if (!value.contains("@")) {
                        return "يجب البريد يحتوي على @";
                      }
                      if (!value.contains(".")) {
                        return "يجب البريد يحتوي على .";
                      }
                      return null;
                    },
                  ),
                  CustomTextFieldForm(
                    title: "رقم الجوال",
                    controller: cubitAuth.phoneController,
                    icon: const Icon(Icons.phone),
                    maxLength: 10,
                    validator: (value) {
                      if (value == "" || value == null) {
                        return "رقم الهاتف مطلوب";
                      }
                      if (!value.startsWith("0")) {
                        return "يجب رقم الهاتف يبدأ ب 0";
                      }
                      if (value.length != 10) {
                        return "يجب رقم الهاتف يحتوي 10 على ارقام";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: BlocConsumer<AuthCubit, AuthState>(
                      listener: (context, state) {
                        const CircularProgressIndicator(
                          color: AppColor.primary,
                        );

                        if (state is SuccessAuthState) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AuthScreen(
                                type: 1,
                                email: cubitAuth.emailController.text,
                              ),
                            ),
                          );
                        }
                      },
                      builder: (context, state) {
                        return SizedBox(
                          width: context.getWidth(value: 0.5),
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                cubitAuth.signup();
                              }
                            },
                            child: const Text(
                              'التسجيل',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        );
                      },
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
                        color: AppColor.secondary,
                        fontSize: 16,
                      ),
                    ),
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
