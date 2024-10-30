import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:helper/helper.dart';
import 'package:kan_kan_admin/data/data_repository.dart';
import 'package:kan_kan_admin/layer/deal_data_layer.dart';
import 'package:kan_kan_admin/layer/product_data_layer.dart';
import 'package:kan_kan_admin/model/deal_model.dart';
import 'package:meta/meta.dart';

part 'deal_state.dart';

class DealCubit extends Cubit<DealState> {
  final api = DataRepository();
  //?-- dataLayer
  final dealLayer = GetIt.I.get<DealDataLayer>();
  final productLayer = GetIt.I.get<ProductDataLayer>();

  //?---controller
  final TextEditingController dealNameController = TextEditingController();
  final TextEditingController productController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController maxNumberController = TextEditingController();
  final TextEditingController dealStatusController = TextEditingController();
  final TextEditingController dealTypeController = TextEditingController();
  final TextEditingController dealDurationController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController costController = TextEditingController();
  final TextEditingController deliveryCostController = TextEditingController();
  final TextEditingController estimatedTimeFromController =
      TextEditingController();
  final TextEditingController estimatedTimeToController =
      TextEditingController();

  //?-- table sorting
  bool sort = true;
  int columnIndex = 0;

  List<DateTime?> dealDuration = [];
  DealCubit() : super(DealInitial());

  addDeal() async {
    Future.delayed(Duration.zero);
    try {
      DealModel deal = DealModel.newDeal(
          dealTitle: dealNameController.text.trim(),
          dealDescription: "",
          startDate:
              DateConverter.supabaseDateFormate(dealDuration.first.toString()),
          endDate:
              DateConverter.supabaseDateFormate(dealDuration.last.toString()),
          costPrice: num.parse(costController.text.trim()),
          deliveryPrice: num.parse(deliveryCostController.text.trim()),
          salePrice: num.parse(priceController.text.trim()),
          totalPrice: num.parse(deliveryCostController.text.trim()) +
              num.parse(priceController.text.trim()),
          categoryId: 1,
          estimateDeliveryDateFrom: estimatedTimeFromController.text.trim(),
          estimateDeliveryTimeTo: estimatedTimeToController.text.trim(),
          dealStatus: "private",
          maxOrdersPerUser: int.parse(maxNumberController.text.trim()),
          quantity: int.parse(quantityController.text),
          dealUrl: "dealUrl");
      await api.addNewDeal(
        productId: int.parse(productController.text),
        deal: deal,
      );
      emit(SuccessSate());
    } catch (errorMessage) {
      emit(ErrorState(errorMessage: errorMessage.toString()));
    }
  }

  sortEvent() {
    emit(SortSuccessSate());
  }
}
