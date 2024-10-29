import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kan_kan_admin/cubits/product_cubit/product_cubit.dart';
import 'package:kan_kan_admin/helper/table_data_row.dart';
import 'package:kan_kan_admin/widget/bottom_sheet/custom_bottom_sheet.dart';
import 'package:kan_kan_admin/widget/button/add_button.dart';
import 'package:kan_kan_admin/widget/form/product_form.dart';
import 'package:kan_kan_admin/widget/table/custom_table_theme.dart';
import 'package:kan_kan_admin/widget/table/table_sized_box.dart';
import 'package:ui/component/helper/custom_colors.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductCubit(),
      child: Builder(builder: (context) {
        final productCubit = context.read<ProductCubit>();
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AddButton(
                onPressed: () {
                  customBottomSheet(
                    context: context,
                    child: ProductForm( 
                      text:  "إضافة المنتج",
                      factoryList: productCubit.factoryLayer.factories,
                      formKey: formKey,
                      descriptionController: productCubit.descriptionController,
                      productNameController: productCubit.productNameController,
                      factoryNameController: productCubit.factoryNameController,
                      modelNumberController: productCubit.modelNumberController,
                      weightController: productCubit.weightController,
                      hightController: productCubit.hightController,
                      lengthController: productCubit.lengthController,
                      widthController: productCubit.widthController,
                      add: () {
                        if (formKey.currentState!.validate()) {
                          productCubit.addProduct();
                        }
                      },
                      uploadImage: () {},
                    ),
                  );
                },
              ),
              BlocBuilder<ProductCubit, ProductState>(
                builder: (context, state) {
                  return TableSizedBox(
                    child: CustomTableTheme(
                      child: PaginatedDataTable(
                        showEmptyRows: false,
                        source: TableDataRow(
                          length: productCubit.productLayer.products.length,
                          customRow: List.generate(
                            productCubit.productLayer.products.length,
                            (index) => DataRow(
                              color: WidgetStateProperty.all(AppColor.white),
                              cells: [
                                DataCell(
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          productCubit
                                                  .descriptionController.text =
                                              productCubit
                                                  .productLayer
                                                  .products[index]
                                                  .productDescription;
                                          productCubit
                                                  .productNameController.text =
                                              productCubit.productLayer
                                                  .products[index].productName;

                                          productCubit
                                                  .modelNumberController.text =
                                              productCubit.productLayer
                                                  .products[index].modelNumber;

                                          productCubit.weightController.text =
                                              productCubit.productLayer
                                                  .products[index].weight
                                                  .toString();

                                          productCubit.hightController.text =
                                              productCubit.productLayer
                                                  .products[index].height
                                                  .toString();

                                          productCubit.lengthController.text =
                                              productCubit.productLayer
                                                  .products[index].length
                                                  .toString();

                                          productCubit.widthController.text =
                                              productCubit.productLayer
                                                  .products[index].width
                                                  .toString();
                                          productCubit
                                                  .factoryNameController.text =
                                              productCubit
                                                  .productLayer
                                                  .products[index]
                                                  .factory
                                                  .factoryId
                                                  .toString();
                                          customBottomSheet(
                                            context: context,
                                            child: ProductForm(
                                              text:  "تعديل المنتج",
                                              factoryList: productCubit
                                                  .factoryLayer.factories,
                                              formKey: formKey,
                                              descriptionController:
                                                  productCubit
                                                      .descriptionController,
                                              productNameController:
                                                  productCubit
                                                      .productNameController,
                                              factoryNameController:
                                                  productCubit
                                                      .factoryNameController,
                                              modelNumberController:
                                                  productCubit
                                                      .modelNumberController,
                                              weightController:
                                                  productCubit.weightController,
                                              hightController:
                                                  productCubit.hightController,
                                              lengthController:
                                                  productCubit.lengthController,
                                              widthController:
                                                  productCubit.widthController,
                                              add: () {
                                                if (formKey.currentState!
                                                    .validate()) {
                                                  productCubit
                                                      .updateProductEvent(
                                                          productId:
                                                              productCubit
                                                                  .productLayer
                                                                  .products[
                                                                      index]
                                                                  .productId,
                                                                  );
                                                  Navigator.pop(context);
                                                }
                                              },
                                              uploadImage: () {},
                                            ),
                                          );
                                        },
                                        icon: const Icon(Icons.edit),
                                      ),
                                      Text(
                                          "${productCubit.productLayer.products[index].productName}\n${productCubit.productLayer.products[index].productId}")
                                    ],
                                  ),
                                ),
                                DataCell(Center(
                                  child: Text(productCubit.productLayer
                                      .products[index].factory.factoryName),
                                )),
                                DataCell(Center(
                                  child: Text(productCubit.productLayer
                                      .products[index].modelNumber),
                                )),
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
                            headingRowAlignment: MainAxisAlignment.center,
                            label: Text("مصنع"),
                          ),
                          DataColumn(
                            headingRowAlignment: MainAxisAlignment.center,
                            label: Text("رقم الموديل "),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      }),
    );
  }
}
