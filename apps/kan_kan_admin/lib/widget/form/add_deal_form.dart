import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kan_kan_admin/model/category_model.dart';
import 'package:kan_kan_admin/model/product_model.dart';
import 'package:kan_kan_admin/widget/form/form_divider.dart';
import 'package:ui/component/helper/screen.dart';
import 'package:ui/component/widget/custom_drop_down_menu.dart';
import 'package:ui/component/widget/custom_text_field_form.dart';

class AddDealForm extends StatelessWidget {
  const AddDealForm({
    super.key,
    required this.dealNameController,
    required this.productController,
    required this.quantityController,
    required this.maxNumberController,
    required this.dealStatusController,
    required this.dealTypeController,
    required this.dealDurationController,
    required this.priceController,
    required this.costController,
    required this.formKey,
    required this.add,
    required this.uploadImage,
    required this.productsList,
    required this.dealDuration,
    required this.deliveryCostController,
    required this.estimatedTimeFromController,
    required this.estimatedTimeToController,
    required this.dealCategory,
  });
  final TextEditingController dealNameController;
  final TextEditingController productController;
  final TextEditingController quantityController;
  final TextEditingController maxNumberController;
  final TextEditingController dealStatusController;
  final TextEditingController dealTypeController;
  final TextEditingController dealDurationController;
  final TextEditingController priceController;
  final TextEditingController costController;
  final TextEditingController deliveryCostController;
  final TextEditingController estimatedTimeFromController;
  final TextEditingController estimatedTimeToController;
  final List<CategoryModel> dealCategory;
  final GlobalKey<FormState> formKey;
  final void Function() add;
  final void Function() uploadImage;
  final List<ProductModel> productsList;
  final dynamic Function()? dealDuration;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 39,
            ),
            const FormDivider(text: "معلومات الصفقة"),
            const SizedBox(
              height: 39,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: CustomTextFieldForm(
                    title: "اسم الصفقة",
                    controller: dealNameController,
                    validator: (value) =>
                        value == null || value.isEmpty ? "required" : null,
                  ),
                ),
                if (dealStatusController.text.isEmpty)
                  Expanded(
                    child: CustomDropDownButton(
                      value: productController.text.isNotEmpty
                          ? productsList
                              .firstWhere((product) =>
                                  product.productId.toString() ==
                                  productController.text)
                              .productId
                          : null,
                      hint: const Text("المنتج"),
                      validator: (value) =>
                          value == null || value.toString().isEmpty
                              ? "required"
                              : null,
                      onChanged: (value) =>
                          productController.text = value.toString(),
                      items: productsList.map<DropdownMenuItem>(
                        (product) {
                          return DropdownMenuItem(
                            value: product.productId,
                            child: Text(product.productName),
                          );
                        },
                      ).toList(),
                    ),
                  ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: CustomTextFieldForm(
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: (value) =>
                        value == null || value.toString().isEmpty
                            ? "required"
                            : null,
                    title: "الكمية",
                    controller: quantityController,
                  ),
                ),
                Expanded(
                  child: CustomTextFieldForm(
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: (value) {
                      if (value == null || value.toString().isEmpty) {
                        return "required";
                      }
                      if (int.parse(value) >
                          int.parse(quantityController.text)) {
                        return "عدد يجب ان يكون اعلى من الكمية";
                      }

                      if (value == "0") {
                        return "-_-";
                      }

                      return null;
                    },
                    title: "حدد اقصى لكل شخص",
                    controller: maxNumberController,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: CustomDropDownButton(
                    validator: (value) =>
                        value == null || value.toString().isEmpty
                            ? "required"
                            : null,
                    onChanged: (value) =>
                        dealTypeController.text = value.toString(),
                    hint: const Text("نوع الصفقة"),
                    items: dealCategory.map<DropdownMenuItem>(
                      (category) {
                        return DropdownMenuItem(
                          value: category.categoryId,
                          child: Text(category.categoryName),
                        );
                      },
                    ).toList(),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 39,
            ),
            const FormDivider(text: "مدة الصفقة"),
            const SizedBox(
              height: 39,
            ),
            CustomTextFieldForm(
              readOnly: true,
              validator: (value) =>
                  value == null || value.toString().isEmpty ? "required" : null,
              controller: dealDurationController,
              title: "مدة الصفقة",
              onTap: dealDuration,
            ),
            const SizedBox(
              height: 39,
            ),
            const FormDivider(text: "رسوم"),
            const SizedBox(
              height: 39,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: CustomTextFieldForm(
                    controller: costController,
                    validator: (value) =>
                        value == null || value.toString().isEmpty
                            ? "required"
                            : null,
                    title: "التكلفة",
                  ),
                ),
                Expanded(
                    child: CustomTextFieldForm(
                        controller: deliveryCostController,
                        validator: (value) =>
                            value == null || value.toString().isEmpty
                                ? "required"
                                : null,
                        title: "رسوم الجمارك والتوصيل")),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: CustomTextFieldForm(
                  title: "سعر البيع",
                  controller: priceController,
                  validator: (value) =>
                      value == null || value.toString().isEmpty
                          ? "required"
                          : null,
                )),
                SizedBox(
                    width: context.getWidth(value: .3),
                    child: const Center(child: Text("الإجمالي: 1599 ريال"))),
              ],
            ),
            const SizedBox(
              height: 39,
            ),
            const FormDivider(text: "التوصيل"),
            const SizedBox(
              height: 39,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: CustomTextFieldForm(
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: (value) =>
                        value == null || value.toString().isEmpty
                            ? "required"
                            : null,
                    title: "من",
                    controller: estimatedTimeFromController,
                  ),
                ),
                Expanded(
                  child: CustomTextFieldForm(
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: (value) {
                      if (value == null || value.toString().isEmpty) {
                        return "required";
                      }

                      if (value == "0") {
                        return "-_-";
                      }

                      return null;
                    },
                    title: "الى",
                    controller: estimatedTimeToController,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 39,
            ),
            SizedBox(
              width: context.getWidth(value: 0.75),
              height: 50,
              child: ElevatedButton(
                onPressed: uploadImage,
                child: const Text("إرفاق صورة"),
              ),
            ),
            const SizedBox(
              height: 39,
            ),
            SizedBox(
              width: context.getWidth(value: 0.75),
              height: 50,
              child: ElevatedButton(
                onPressed: add,
                child: const Text("اضافة"),
              ),
            ),
            const SizedBox(
              height: 39,
            ),
          ],
        ),
      ),
    );
  }
}
