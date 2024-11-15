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
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'deal_details_state.dart';

class DealDetailsCubit extends Cubit<DealDetailsState> {
  final api = DataRepository();
  //?-- data layer
  final orderLayer = GetIt.I.get<OrderDataLayer>();
  final userLayer = GetIt.I.get<UserLayer>();
  final productLayer = GetIt.I.get<ProductDataLayer>();
  final factoryLayer = GetIt.I.get<FactoryDataLayer>();
  final dealLayer = GetIt.I.get<DealDataLayer>();
  final categoryLayer = GetIt.I.get<CategoryDataLayer>();

  //?---controller
  final TextEditingController trackingNumberController =
      TextEditingController();

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
  late DealModel deal;
  //?--tmp
  String tmpStatus = '';
  String tmpOrderStatus = 'processing';

  String oneOrderStatus = '';
  String onePaymentStatus = '';

  List<DateTime?> dealDuration = [];
  List<OrderModel> currentOrders = [];

  DealDetailsCubit() : super(DealDetailsInitial()) {
    addNewOrder();
    completeDeal();
  }

  dealOrders({required int dealId}) {
    currentOrders = orderLayer.orders
        .where((OrderModel order) => order.dealId == dealId)
        .toList();
    deal = dealLayer.deals.firstWhere((deal) => deal.dealId == dealId);
  }

  updateDealEvent() async {
    try {
      DealModel updateDeal = DealModel(
        numberOfOrder: deal.numberOfOrder,
        product: deal.product,
        dealId: deal.dealId,
        trackingNumber: deal.trackingNumber,
        dealTitle: dealNameController.text.trim(),
        dealDescription: deal.dealDescription,
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
        dealStatus: deal.dealStatus,
        maxOrdersPerUser: int.parse(maxNumberController.text.trim()),
        quantity: int.parse(quantityController.text),
        dealUrl: "dealUrl",
      );
      final response = await api.updateDeal(
          deal: updateDeal,
          productId: int.parse(productController.text),
          dealId: deal.dealId);
      if (response) {
        int index = dealLayer.deals
            .indexWhere((element) => element.dealId == deal.dealId);

        dealLayer.deals[index] = updateDeal;
        deal = updateDeal;
      }
      if (!isClosed) emit(UpdateDealStatusSuccessState());
    } catch (errorMessage) {
      if (!isClosed) emit(ErrorStatus(errorMessage: errorMessage.toString()));
    }
  }

  updateDealStatusEvent() async {
    try {
      final response = await api.updateDealStatus(
          dealId: deal.dealId, dealStatus: tmpStatus);
      if (response) {
        int index = dealLayer.deals
            .indexWhere((element) => element.dealId == deal.dealId);
        dealLayer.deals[index].dealStatus = tmpStatus;
        deal.dealStatus = tmpStatus;
      }
      if (!isClosed) emit(UpdateDealStatusSuccessState());
    } catch (errorMessage) {
      if (!isClosed) emit(ErrorStatus(errorMessage: errorMessage.toString()));
    }
  }

  updateOrderStatus({required int dealId}) async {
    try {
      List<int> listOrderIndex = [];
      List<int> listOrdersId = [];

      for (int index = 0; index < orderLayer.orders.length; index++) {
        if (orderLayer.orders[index].dealId == dealId) {
          listOrderIndex.add(index);
          listOrdersId.add(orderLayer.orders[index].orderId);
        }
      }
      final response = await api.updateAllOrdersStatus(
        dealId: dealId,
        status: tmpOrderStatus,
      );
      if (tmpOrderStatus == "withShipmentCompany") {
        await api.sendTrackingNumber(
            listOrdersId: listOrdersId, dealName: deal.dealTitle);
      }
      if (response) {
        await Future.wait([
          api.updateDealNumberOfOrder(dealId: dealId, numberOfOrder: 0),
          api.addToTracking(ordersId: listOrdersId, status: tmpOrderStatus)
        ]);
        for (int index in listOrderIndex) {
          orderLayer.orders[index].orderStatus = tmpOrderStatus;
        }
      }

      currentOrders = orderLayer.orders
          .where((OrderModel order) => order.dealId == dealId)
          .toList();
      if (!isClosed) emit(UpdateOrderStatusSuccessState());
    } catch (errorMessage) {
      if (!isClosed) emit(ErrorStatus(errorMessage: errorMessage.toString()));
    }
  }

  updateOneOrderStatus({required int index}) async {
    try {
      final response = await api.updateOrderStatus(
          orderId: currentOrders[index].orderId, status: oneOrderStatus);
      if (response) {
        final globalIndex = orderLayer.orders.indexWhere(
            (element) => element.orderId == currentOrders[index].orderId);
        currentOrders[index].orderStatus = oneOrderStatus;
        orderLayer.orders[globalIndex].orderStatus = oneOrderStatus;

        if (oneOrderStatus == "canceled") {
          int dealIndex = dealLayer.deals
              .indexWhere((element) => deal.dealId == element.dealId);
          dealLayer.deals[dealIndex].numberOfOrder - 1;
          if (dealLayer.deals[dealIndex].numberOfOrder < 0) {
            dealLayer.deals[dealIndex].numberOfOrder = 0;
          }
          await api.updateDealNumberOfOrder(
              dealId: orderLayer.orders[index].dealId,
              numberOfOrder: dealLayer.deals[dealIndex].numberOfOrder.toInt());
        }
        if (!isClosed) emit(UpdateOrderStatusSuccessState());
      }
    } catch (errorMessage) {
      if (!isClosed) emit(ErrorStatus(errorMessage: errorMessage.toString()));
    }
  }

  updateOnePaymentStatus({required int index}) async {
    try {
      final response = await api.updatePaymentStatus(
          orderId: currentOrders[index].orderId, status: onePaymentStatus);
      if (response) {
        int globalIndex = orderLayer.orders.indexWhere(
            (element) => currentOrders[index].orderId == element.orderId);
        currentOrders[index].paymentStatus = onePaymentStatus;
        orderLayer.orders[globalIndex].paymentStatus = onePaymentStatus;
      }
      if (!isClosed) emit(UpdateOrderStatusSuccessState());
    } catch (errorMessage) {
      if (!isClosed) emit(ErrorStatus(errorMessage: errorMessage.toString()));
    }
  }

  addTrackingNumberEvent() async {
    try {
      final response = await api.addTrackingNumber(
          dealId: deal.dealId,
          trackingNumber: trackingNumberController.text.trim());
      if (response) {
        deal.trackingNumber = trackingNumberController.text.trim();
        int index = dealLayer.deals
            .indexWhere((element) => element.dealId == deal.dealId);
        dealLayer.deals[index].trackingNumber =
            trackingNumberController.text.trim();
      }
      if (!isClosed) emit(UpdateDealStatusSuccessState());
    } catch (errorMessage) {
      if (!isClosed) emit(ErrorStatus(errorMessage: errorMessage.toString()));
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
                deal.dealStatus = "completed";
              }
              dealLayer.deals[index].numberOfOrder =
                  updateDeal.newRecord["number_of_order"];
              deal.numberOfOrder = updateDeal.newRecord["number_of_order"];
              if (!isClosed) emit(UpdateDealStatusSuccessState());
            })
        .subscribe();
    if (!isClosed) emit(UpdateDealStatusSuccessState());
  }

  addNewOrder() {
    KanSupabase.supabase.client
        .channel('add_order')
        .onPostgresChanges(
            event: PostgresChangeEvent.insert,
            schema: 'public',
            table: 'orders',
            callback: (newData) {
              orderLayer.orders.add(OrderModel.fromJson(newData.newRecord));
              if (currentOrders.first.dealId ==
                  OrderModel.fromJson(newData.newRecord).dealId) {
                currentOrders.add(OrderModel.fromJson(newData.newRecord));
              }
              if (!isClosed) emit(UpdateDealStatusSuccessState());
            })
        .subscribe();
    if (!isClosed) emit(UpdateDealStatusSuccessState());
  }
}
