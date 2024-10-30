import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:helper/helper.dart';
import 'package:kan_kan_admin/data/data_repository.dart';
import 'package:kan_kan_admin/layer/factory_data_layer.dart';
import 'package:kan_kan_admin/layer/order_data_layer.dart';
import 'package:kan_kan_admin/layer/product_data_layer.dart';
import 'package:kan_kan_admin/layer/user_layer.dart';
import 'package:kan_kan_admin/model/deal_model.dart';
import 'package:kan_kan_admin/model/order_model2.dart';
import 'package:meta/meta.dart';

part 'deal_details_state.dart';

class DealDetailsCubit extends Cubit<DealDetailsState> {
  DealDetailsCubit() : super(DealDetailsInitial());
  final api = DataRepository();
  //?-- data layer
  final orderLayer = GetIt.I.get<OrderDataLayer>();
  final userLayer = GetIt.I.get<UserLayer>();
  final productLayer = GetIt.I.get<ProductDataLayer>();
  final factoryLayer = GetIt.I.get<FactoryDataLayer>();

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

  List<DateTime?> dealDuration = [];
  List<OrderModel> currentOrders = [];

  dealOrders({required int dealId}) {
    currentOrders = orderLayer.orders
        .where((OrderModel order) => order.dealId == dealId)
        .toList();
  }

  updateDealEvent({required int dealId}) async {
    try {
      print("create deal");
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
      print("call update deal");
      await api.updateDeal(
          deal: deal,
          productId: int.parse(productController.text),
          dealId: dealId);
    } catch (e) {
      print(e);
    }
  }
}
