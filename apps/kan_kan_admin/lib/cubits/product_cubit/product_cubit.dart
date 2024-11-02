import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:kan_kan_admin/data/data_repository.dart';
import 'package:kan_kan_admin/layer/factory_data_layer.dart';
import 'package:kan_kan_admin/layer/product_data_layer.dart';
import 'package:kan_kan_admin/model/factory_model.dart';
import 'package:kan_kan_admin/model/product_model.dart';
import 'package:meta/meta.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  //?-- data layer
  final productLayer = GetIt.I.get<ProductDataLayer>();
  final factoryLayer = GetIt.I.get<FactoryDataLayer>();

  //?-- supabase repository
  final api = DataRepository();

  //?-- controllers
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController factoryNameController = TextEditingController();
  final TextEditingController modelNumberController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController hightController = TextEditingController();
  final TextEditingController lengthController = TextEditingController();
  final TextEditingController widthController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  //?-- table sorting
  bool sort = true;
  int columnIndex = 0;

  //? list of images
  List<File> images = [];

  ProductCubit() : super(ProductInitial());

  void addProduct() async {
    await Future.delayed(Duration.zero);
    try {
      ProductModel addedProduct = await api.addNewProduct(
        product: ProductModel(
            images: [],
            width: num.parse(widthController.text.trim()),
            height: num.parse(hightController.text.trim()),
            length: num.parse(lengthController.text.trim()),
            weight: num.parse(weightController.text.trim()),
            productId: 0,
            defaultPrice: 0,
            factory: FactoryModel.empty(),
            productName: productNameController.text.trim(),
            productDescription: descriptionController.text.trim(),
            modelNumber: modelNumberController.text.trim()),
        factoryId: int.parse(factoryNameController.text.trim()),
      );
      if (images.isNotEmpty && images != []) {
        await api.uploadProductsImages(
            images: images, productId: addedProduct.productId);
      }
      if (addedProduct.productId != 0) {
        productLayer.products.add(addedProduct);
      }
      emit(AddProductSuccessState());
    } catch (errorMessage) {
      emit(
        ErrorState(errorMessage: errorMessage.toString()),
      );
    }
  }

  void updateProductEvent(
      {required int index,
      required int productId,
      required int factoryId}) async {
    await Future.delayed(Duration.zero);
    try {
      ProductModel updateProduct = ProductModel(
          images: [],
          width: num.parse(widthController.text.trim()),
          height: num.parse(hightController.text.trim()),
          length: num.parse(lengthController.text.trim()),
          weight: num.parse(weightController.text.trim()),
          productId: productId,
          defaultPrice: 0,
          factory: FactoryModel.empty(),
          productName: productNameController.text.trim(),
          productDescription: descriptionController.text.trim(),
          modelNumber: modelNumberController.text.trim());
      final response = await api.updateProduct(
        product: updateProduct,
        factoryId: int.parse(factoryNameController.text.trim()),
      );
      if (response) {
        updateProduct.factory = factoryLayer.getFactory(id: factoryId);
        productLayer.products[index] = updateProduct;
      }
      emit(UpdateProductSuccessState());
    } catch (errorMessage) {
      emit(
        ErrorState(errorMessage: errorMessage.toString()),
      );
    }
  }

  sortEvent() async {
    await Future.delayed(Duration.zero);
    emit(SortSuccessState());
  }
}
