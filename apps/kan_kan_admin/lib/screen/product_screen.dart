import 'package:flutter/material.dart';
import 'package:kan_kan_admin/helper/table_data_row.dart';
import 'package:kan_kan_admin/model/dummy%20data/product_dummy.dart';
import 'package:kan_kan_admin/widget/bottom_sheet/custom_bottom_sheet.dart';
import 'package:kan_kan_admin/widget/button/add_button.dart';
import 'package:kan_kan_admin/widget/form/product_form.dart';
import 'package:kan_kan_admin/widget/table/custom_table_theme.dart';
import 'package:kan_kan_admin/widget/table/table_sized_box.dart';
import 'package:ui/component/helper/custom_colors.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController productNameController = TextEditingController();
    final TextEditingController factoryNameController = TextEditingController();
    final TextEditingController modelNumberController = TextEditingController();
    final TextEditingController wightController = TextEditingController();
    final TextEditingController hightController = TextEditingController();
    final TextEditingController lengthController = TextEditingController();
    final TextEditingController widthController = TextEditingController();

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AddButton(
            onPressed: () {
              customBottomSheet(
                context: context,
                child: ProductForm(
                  productNameController: productNameController,
                  factoryNameController: factoryNameController,
                  modelNumberController: modelNumberController,
                  wightController: wightController,
                  hightController: hightController,
                  lengthController: lengthController,
                  widthController: widthController,
                  add: () {},
                  uploadImage: () {},
                ),
              );
            },
          ),
          TableSizedBox(
            child: CustomTableTheme(
              child: PaginatedDataTable(
                showEmptyRows: false,
                headingRowColor: const WidgetStatePropertyAll(AppColor.white),
                source: TableDataRow(
                  length: productsList.length,
                  customRow: List.generate(
                    productsList.length,
                    (index) => DataRow(
                      color: WidgetStateProperty.all(AppColor.white),
                      cells: [
                        DataCell(
                          Row(
                            children: [
                              Text(
                                  "${productsList[index].productName}\n${productsList[index].id}")
                            ],
                          ),
                        ),
                        DataCell(Text(productsList[index].factory)),
                        DataCell(Text(productsList[index].modelNumber)),
                      ],
                    ),
                  ),
                ),
                columns: const [
                  DataColumn(
                    headingRowAlignment: MainAxisAlignment.center,
                    label: Text("المنتج"),
                  ),
                  DataColumn(
                    label: Text("مصنع"),
                  ),
                  DataColumn(
                    headingRowAlignment: MainAxisAlignment.center,
                    label: Text("رقم الموديل "),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
