import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kan_kan_admin/widget/form/form_divider.dart';
import 'package:ui/component/helper/screen.dart';
import 'package:ui/component/widget/custom_text_field_form.dart';

class FactoryForm extends StatelessWidget {
  const FactoryForm({
    super.key,
    required this.factoryNameController,
    required this.regionController,
    required this.typeController,
    required this.repController,
    required this.phoneNumberController,
    required this.onPressed,
    this.formKey,
  });
  final TextEditingController factoryNameController;
  final TextEditingController regionController;
  final TextEditingController typeController;
  final TextEditingController repController;
  final TextEditingController phoneNumberController;
  final void Function() onPressed;
  final GlobalKey<FormState>? formKey;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox(
              height: 30,
            ),
            const FormDivider(
              text: "معلومات المصنع",
            ),
            SizedBox(
              child: Row(
                children: [
                  Expanded(
                    child: CustomTextFieldForm(
                      controller: factoryNameController,
                      title: "اسم*",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'هذا حقل مطلوب';
                        }
                        return null;
                      },
                    ),
                  ),
                  Expanded(
                    child: CustomTextFieldForm(
                      controller: regionController,
                      title: "المنطقة*",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'هذا حقل مطلوب';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: context.getHeight(value: .1),
              width: context.getWidth(value: .273),
              child: CustomTextFieldForm(
                controller: typeController,
                title: "نوع تصنيع*",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'هذا حقل مطلوب';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const FormDivider(
              text: "معلومات ممثل المصنع",
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              child: Row(
                children: [
                  Expanded(
                    child: CustomTextFieldForm(
                      controller: repController,
                      title: "اسم*",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'هذا حقل مطلوب';
                        }
                        return null;
                      },
                    ),
                  ),
                  Expanded(
                    child: CustomTextFieldForm(
                      controller: phoneNumberController,
                      title: "رقم التواصل*",
                      keyboardType: TextInputType.phone,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9+]+'))
                      ],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'هذا حقل مطلوب';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Center(
              child: ElevatedButton(
                onPressed: onPressed,
                child: const Text('اضافة'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
