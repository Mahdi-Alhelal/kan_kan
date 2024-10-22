import 'package:flutter/material.dart';
import 'package:kan_kan_admin/widget/form/form_divider.dart';
import 'package:ui/component/helper/screen.dart';
import 'package:ui/component/widget/custom_text_field.dart';

class CustomForm extends StatelessWidget {
  const CustomForm({
    super.key,
    required this.factoryNameController,
    required this.regionController,
    required this.typeController,
    required this.repController,
    required this.phoneNumberController,
    required this.onPressed,
  });
  final TextEditingController factoryNameController;
  final TextEditingController regionController;

  final TextEditingController typeController;

  final TextEditingController repController;

  final TextEditingController phoneNumberController;
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const FormDivider(
          text: "معلومات المصنع",
        ),
        SizedBox(
          child: Row(
            children: [
              Expanded(
                child: CustomTextField(
                  controller: factoryNameController,
                  title: "اسم",
                ),
              ),
              Expanded(
                child: CustomTextField(
                  controller: regionController,
                  title: "المنطقة",
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: context.getHeight(value: .1),
          width: context.getWidth(value: .273),
          child: CustomTextField(
            controller: typeController,
            title: "نوع تصنيع",
          ),
        ),
        const FormDivider(
          text: "معلومات ممثل المصنع",
        ),
        SizedBox(
          child: Row(
            children: [
              Expanded(
                child: CustomTextField(
                  controller: repController,
                  title: "اسم",
                ),
              ),
              Expanded(
                child: CustomTextField(
                  controller: phoneNumberController,
                  title: "رقم التواصل",
                ),
              ),
            ],
          ),
        ),
        Center(
          child: ElevatedButton(
            child: const Text('اضافة'),
            onPressed: onPressed,
          ),
        ),
      ],
    );
  }
}
