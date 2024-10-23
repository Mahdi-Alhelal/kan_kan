
import 'package:flutter/material.dart';
import 'package:kan_kan_admin/widget/button/custom_button.dart';
import 'package:kan_kan_admin/widget/form/form_divider.dart';
import 'package:ui/component/helper/screen.dart';
import 'package:ui/component/widget/custom_text_field.dart';

class ProductForm extends StatelessWidget {
  const ProductForm(
      {super.key,
      required this.productNameController,
      required this.factoryNameController,
      required this.modelNumberController,
      required this.wightController,
      required this.hightController,
      required this.lengthController,
      required this.widthController,
      required this.add,
      required this.uploadImage});

  final TextEditingController productNameController;
  final TextEditingController factoryNameController;
  final TextEditingController modelNumberController;
  final TextEditingController wightController;
  final TextEditingController hightController;
  final TextEditingController lengthController;
  final TextEditingController widthController;
  final void Function()? uploadImage;
  final void Function()? add;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          children: [
            Expanded(
              child: CustomTextField(
                title: "المنتج",
                controller: productNameController,
              ),
            ),
            Expanded(
              child: CustomTextField(
                title: "مصنع",
                controller: factoryNameController,
              ),
            ),
          ],
        ),
        SizedBox(
          height: context.getHeight(value: 0.1),
          child: Expanded(
            child: CustomTextField(
              title: "رقم الموديل",
              controller: modelNumberController,
            ),
          ),
        ),
        const FormDivider(text: "مقاسات المنتج"),
        Row(
          children: [
            Expanded(
              child: CustomTextField(
                title: "وزن KG",
                controller: wightController,
              ),
            ),
            Expanded(
              child: CustomTextField(
                title: "إرتفاع cm",
                controller: hightController,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: CustomTextField(
                title: "طول cm",
                controller: lengthController,
              ),
            ),
            Expanded(
              child: CustomTextField(
                title: "العرض cm",
                controller: widthController,
              ),
            ),
          ],
        ),
        CustomButton(
          text: "إرفاق صورة",
          onPressed: uploadImage,
        ),
        CustomButton(
          text: "اضافة",
          onPressed: add,
        ),
      ],
    );
  }
}
