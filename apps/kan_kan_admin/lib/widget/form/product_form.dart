import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kan_kan_admin/model/factory_model.dart';
import 'package:kan_kan_admin/widget/button/custom_button.dart';
import 'package:kan_kan_admin/widget/form/form_divider.dart';
import 'package:ui/component/helper/screen.dart';
import 'package:ui/component/widget/custom_drop_down_menu.dart';
import 'package:ui/component/widget/custom_text_field_form.dart';

class ProductForm extends StatelessWidget {
  const ProductForm({
    super.key,
    required this.productNameController,
    required this.factoryNameController,
    required this.modelNumberController,
    required this.weightController,
    required this.hightController,
    required this.lengthController,
    required this.widthController,
    required this.descriptionController,
    required this.add,
    required this.uploadImage,
    this.formKey,
    required this.factoryList,
    required this.text,
  });

  final TextEditingController productNameController;
  final TextEditingController factoryNameController;
  final TextEditingController modelNumberController;
  final TextEditingController weightController;
  final TextEditingController hightController;
  final TextEditingController lengthController;
  final TextEditingController widthController;
  final TextEditingController descriptionController;
  final void Function()? uploadImage;
  final void Function()? add;
  final GlobalKey<FormState>? formKey;
  final List<FactoryModel> factoryList;
  final String text;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            FormDivider(text: text),
            Row(
              children: [
                Expanded(
                  child: CustomTextFieldForm(
                    validator: (value) => value == null || value.isEmpty
                        ? "هذا الحقل مطلوي"
                        : null,
                    title: "المنتج",
                    controller: productNameController,
                  ),
                ),
                Expanded(
                  child: CustomDropDownButton(
                    value: factoryNameController.text.isNotEmpty
                        ? factoryList
                            .firstWhere((factory) =>
                                factory.factoryId.toString() ==
                                factoryNameController.text)
                            .factoryId
                        : null,
                    validator: (value) =>
                        value == null ? "هذا الحقل مطلوب" : null,
                    onChanged: (value) =>
                        factoryNameController.text = value.toString(),
                    items: factoryList
                        .map<DropdownMenuItem>(
                          (FactoryModel element) => DropdownMenuItem(
                            value: element.factoryId,
                            child: Text(
                              element.factoryName,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: context.getHeight(value: 0.1),
              child: CustomTextFieldForm(
                validator: (value) =>
                    value == null || value.isEmpty ? "هذا الحقل مطلوي" : null,
                title: "رقم الموديل",
                controller: modelNumberController,
              ),
            ),
            const FormDivider(text: "مقاسات المنتج"),
            Row(
              children: [
                Expanded(
                  child: CustomTextFieldForm(
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "هذا الحقل مطلوي";
                      }
                      if (value == "0" || int.parse(value) < 0) {
                        return "-_-";
                      }
                      return null;
                    },
                    title: "وزن KG",
                    controller: weightController,
                  ),
                ),
                Expanded(
                  child: CustomTextFieldForm(
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "هذا الحقل مطلوي";
                      }
                      if (value == "0" || int.parse(value) < 0) {
                        return "-_-";
                      }
                      return null;
                    },
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
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "هذا الحقل مطلوي";
                      }
                      if (value == "0" || int.parse(value) < 0) {
                        return "-_-";
                      }
                      return null;
                    },
                    title: "طول cm",
                    controller: lengthController,
                  ),
                ),
                Expanded(
                  child: CustomTextFieldForm(
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "هذا الحقل مطلوي";
                      }
                      if (value == "0" || int.parse(value) < 0) {
                        return "-_-";
                      }
                      return null;
                    },
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
                validator: (value) =>
                    value == null || value.isEmpty ? "هذا الحقل مطلوي" : null,
                title: "",
                controller: descriptionController,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            CustomButton(
              text: "إرفاق صورة",
              onPressed: uploadImage,
            ),
            const SizedBox(
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
