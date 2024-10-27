import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:kan_kan_admin/data/data_repository.dart';
import 'package:kan_kan_admin/layer/product_data_layer.dart';
import 'package:meta/meta.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final productLayer = GetIt.I.get<ProductDataLayer>();
  final api = DataRepository();

  //?-- controllers
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController factoryNameController = TextEditingController();
  final TextEditingController modelNumberController = TextEditingController();
  final TextEditingController wightController = TextEditingController();
  final TextEditingController hightController = TextEditingController();
  final TextEditingController lengthController = TextEditingController();
  final TextEditingController widthController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  ProductCubit() : super(ProductInitial());
}
