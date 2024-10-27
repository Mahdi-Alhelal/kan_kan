import 'package:flutter/material.dart';
import 'package:kan_kan_admin/widget/button/custom_button.dart';
import 'package:kan_kan_admin/widget/form/form_divider.dart';
import 'package:ui/component/helper/screen.dart';
import 'package:ui/component/widget/custom_text_field_form.dart';

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
      required this.descriptionController,
      required this.add,
      required this.uploadImage});

  final TextEditingController productNameController;
  final TextEditingController factoryNameController;
  final TextEditingController modelNumberController;
  final TextEditingController wightController;
  final TextEditingController hightController;
  final TextEditingController lengthController;
  final TextEditingController widthController;
  final TextEditingController descriptionController;
  final void Function()? uploadImage;
  final void Function()? add;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const FormDivider(text: "إضافة المنتج"),
            Row(
              children: [
                Expanded(
                  child: CustomTextFieldForm(
                    title: "المنتج",
                    controller: productNameController,
                  ),
                ),
                Expanded(
                  child: CustomTextFieldForm(
                    title: "مصنع",
                    controller: factoryNameController,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: context.getHeight(value: 0.1),
              child: CustomTextFieldForm(
                title: "رقم الموديل",
                controller: modelNumberController,
              ),
            ),
            const FormDivider(text: "مقاسات المنتج"),
            Row(
              children: [
                Expanded(
                  child: CustomTextFieldForm(
                    title: "وزن KG",
                    controller: wightController,
                  ),
                ),
                Expanded(
                  child: CustomTextFieldForm(
                    title: "إرتفاع cm",
                    controller: hightController,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: CustomTextFieldForm(
                    title: "طول cm",
                    controller: lengthController,
                  ),
                ),
                Expanded(
                  child: CustomTextFieldForm(
                    title: "العرض cm",
                    controller: widthController,
                  ),
                ),
              ],
            ),
            const FormDivider(text: "الوصف"),
            SizedBox(
              height: context.getHeight(value: 0.1),
              child: CustomTextFieldForm(
                title: "",
                controller: descriptionController,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            CustomButton(
              text: "إرفاق صورة",
              onPressed: uploadImage,
            ),
            SizedBox(
              height: 30,
            ),
            CustomButton(
              text: "اضافة",
              onPressed: add,
            ),
          ],
        ),
      ),
    );
  }
}
