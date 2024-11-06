import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:helper/helper.dart';
import 'package:kan_kan_admin/data/data_repository.dart';
import 'package:kan_kan_admin/integrations/supabase/supabase_client.dart';
import 'package:kan_kan_admin/layer/category_data_layer.dart';
import 'package:kan_kan_admin/layer/deal_data_layer.dart';
import 'package:kan_kan_admin/layer/factory_data_layer.dart';
import 'package:kan_kan_admin/layer/order_data_layer.dart';
import 'package:kan_kan_admin/layer/product_data_layer.dart';
import 'package:kan_kan_admin/layer/user_layer.dart';
import 'package:kan_kan_admin/model/deal_model.dart';
import 'package:kan_kan_admin/model/order_model.dart';
import 'package:kan_kan_admin/model/user_model.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'deal_state.dart';

class DealCubit extends Cubit<DealState> {
  final api = DataRepository();
  //?-- dataLayer
  final dealLayer = GetIt.I.get<DealDataLayer>();
  final productLayer = GetIt.I.get<ProductDataLayer>();
  final factoryLayer = GetIt.I.get<FactoryDataLayer>();
  final categoryLayer = GetIt.I.get<CategoryDataLayer>();
  final orderLayer = GetIt.I.get<OrderDataLayer>();
  final userLayer = GetIt.I.get<UserLayer>();
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
  final TextEditingController totalCostController = TextEditingController();

  final TextEditingController estimatedTimeFromController =
      TextEditingController();
  final TextEditingController estimatedTimeToController =
      TextEditingController();

  //?-- table sorting
  bool sort = false;
  int columnIndex = 0;

//?--temporary status
  String tempStatus = "";

  List<DateTime?> dealDuration = [];
  File? image;

  DealCubit() : super(DealInitial()) {
    getNewOrder();
    getNewUser();
    completeDeal();
  }

  addDeal() async {
    Future.delayed(Duration.zero);
    try {
      DealModel deal = DealModel.newDeal(
          trackingNumber: "",
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
          categoryId: int.parse(dealTypeController.text),
          estimateDeliveryDateFrom: estimatedTimeFromController.text.trim(),
          estimateDeliveryTimeTo: estimatedTimeToController.text.trim(),
          dealStatus: "private",
          maxOrdersPerUser: int.parse(maxNumberController.text.trim()),
          quantity: int.parse(quantityController.text),
          dealUrl: "");
      final newDeal = await api.addNewDeal(
        productId: int.parse(productController.text),
        deal: deal,
      );
      dealLayer.deals.add(newDeal);
      productController.clear();
      quantityController.clear();
      maxNumberController.clear();
      estimatedTimeToController.clear();
      estimatedTimeFromController.clear();
      priceController.clear();
      deliveryCostController.clear();
      costController.clear();
      dealNameController.clear();
      dealDurationController.clear();
      if (image != null) {
        await api.uploadDealImage(image: image!, dealId: newDeal.dealId);
      }
      if (!isClosed) emit(SuccessSate());
    } catch (errorMessage) {
      if (!isClosed) emit(ErrorState(errorMessage: errorMessage.toString()));
    }
  }

  void sortEvent() {
    if (!isClosed) emit(SortSuccessSate());
  }

  void afterPop() {
    if (!isClosed) emit(AfterPop());
  }

  updateDealStatusEvent({required int dealId, required int index}) async {
    Future.delayed(Duration.zero);

    try {
      final response =
          await api.updateDealStatus(dealId: dealId, dealStatus: tempStatus);
      if (response) {
        dealLayer.deals[index].dealStatus = tempStatus;
        if (!isClosed) emit(SuccessSate());
      }
    } catch (errorMessage) {
      if (!isClosed) emit(ErrorState(errorMessage: errorMessage.toString()));
    }
  }

  completeDeal() {
    KanSupabase.supabase.client
        .channel('completeDeal')
        .onPostgresChanges(
            event: PostgresChangeEvent.all,
            schema: 'public',
            table: 'deals',
            callback: (updateDeal) {
              int dealId = updateDeal.newRecord["deal_id"];
              int index =
                  dealLayer.deals.indexWhere((deal) => deal.dealId == dealId);
              if (updateDeal.newRecord["deal_status"] == "completed") {
                dealLayer.deals[index].dealStatus = "completed";
              }
              
              dealLayer.deals[index].numberOfOrder =
                  updateDeal.newRecord["number_of_order"];
              if (!isClosed) emit(SuccessSate());
            })
        .subscribe();
    if (!isClosed) emit(SuccessSate());
  }

  void getNewUser() {
    KanSupabase.supabase.client
        .channel('add_user')
        .onPostgresChanges(
            event: PostgresChangeEvent.insert,
            schema: 'public',
            table: 'users',
            callback: (newUser) {
              userLayer.usersList.add(UserModel.fromJson(newUser.newRecord));
              if (!isClosed) emit(SuccessSate());
            })
        .subscribe();
    if (!isClosed) emit(SuccessSate());
  }

  getNewOrder() {
    KanSupabase.supabase.client
        .channel('add_order')
        .onPostgresChanges(
            event: PostgresChangeEvent.insert,
            schema: 'public',
            table: 'orders',
            callback: (newData) {
              orderLayer.orders.add(OrderModel.fromJson(newData.newRecord));
              if (!isClosed) emit(SuccessSate());
            })
        .subscribe();
    if (!isClosed) emit(SuccessSate());
  }
}
