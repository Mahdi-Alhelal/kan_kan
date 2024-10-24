import 'package:flutter/material.dart';
import 'package:kan_kan_admin/dummy_data/status_list.dart';
import 'package:kan_kan_admin/widget/form/form_divider.dart';
import 'package:ui/component/helper/screen.dart';
import 'package:ui/component/widget/custom_drop_down_menu.dart';
import 'package:ui/component/widget/custom_text_field_form.dart';

class AddDealScreen extends StatelessWidget {
  const AddDealScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Center(
          child: SizedBox(
            height: context.getHeight(),
            width: context.getWidth(value: .6),
            child: Card(
              child: Form(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
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
                            const Expanded(
                                child:
                                    CustomTextFieldForm(title: "اسم الصفقة")),
                            Expanded(
                              child: CustomDropDownMenu(
                                  onSelected: (value) {
                                    print("onSelected");
                                    print(value);
                                  },
                                  dropdownMenuEntries: DropMenuList.productName
                                      .map<DropdownMenuEntry>((productName) {
                                    return DropdownMenuEntry(
                                      value: productName,
                                      label: productName,
                                    );
                                  }).toList(),
                                  hintText: "إختار منتج"),
                            ),
                          ],
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                child: CustomTextFieldForm(title: "الكمية")),
                            Expanded(
                                child: CustomTextFieldForm(
                                    title: "حدد اقصى لكل شخص")),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: CustomDropDownMenu(
                                  onSelected: (value) {
                                    print("onSelected");
                                    print(value);
                                  },
                                  dropdownMenuEntries: DropMenuList.dealStatus
                                      .map<DropdownMenuEntry>((status) {
                                    return DropdownMenuEntry(
                                      value: status,
                                      label: status,
                                    );
                                  }).toList(),
                                  hintText: "حالة صفقة"),
                            ),
                            Expanded(
                              child: CustomDropDownMenu(
                                  onSelected: (value) {},
                                  dropdownMenuEntries: DropMenuList.dealCategory
                                      .map<DropdownMenuEntry>((category) {
                                    return DropdownMenuEntry(
                                      value: category,
                                      label: category,
                                    );
                                  }).toList(),
                                  hintText: "نوع الصفقة"),
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
                          title: "مدة الصفقة",
                          onTap: () {
                            showDateRangePicker(
                              context: context,
                              firstDate: DateTime.now(),
                              lastDate: DateTime(DateTime.now().year + 20),
                            );
                          },
                        ),
                        const SizedBox(
                          height: 39,
                        ),
                        const FormDivider(text: "رسوم"),
                        const SizedBox(
                          height: 39,
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                child: CustomTextFieldForm(
                                    title: "سعر الصفقة بدون شحن")),
                            Expanded(
                                child: CustomTextFieldForm(
                                    title: "رسوم الجمارك والتوصيل")),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Expanded(
                                child: const CustomTextFieldForm(
                                    title: "سعر الصفقة بدون شحن")),
                            SizedBox(
                                width: context.getWidth(value: .3),
                                child: const Center(
                                    child: Text("الإجمالي: 1599 ريال"))),
                          ],
                        ),
                        const SizedBox(
                          height: 39,
                        ),
                        const FormDivider(text: "التوصيل"),
                        const SizedBox(
                          height: 39,
                        ),
                        CustomTextFieldForm(
                          readOnly: true,
                          title: "الوقت المتوقع للتوصيل",
                          onTap: () {
                            showDateRangePicker(
                              context: context,
                              firstDate: DateTime.now(),
                              lastDate: DateTime(DateTime.now().year + 20),
                            );
                          },
                        ),
                        const SizedBox(
                          height: 39,
                        ),
                        SizedBox(
                          width: context.getWidth(value: 0.75),
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {},
                            child: Text("إرفاق صورة"),
                          ),
                        ),
                        const SizedBox(
                          height: 39,
                        ),
                        SizedBox(
                          width: context.getWidth(value: 0.75),
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {},
                            child: Text("اضافة"),
                          ),
                        ),
                        const SizedBox(
                          height: 39,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
