import 'package:kan_kan/model/product_model.dart';

class DealModel {
  DealModel(
      {required this.dealId,
      required this.dealTitle,
      required this.dealDescription,
      required this.startDate,
      required this.endDate,
      required this.deliveryPrice,
      required this.salePrice,
      required this.totalPrice,
      required this.categoryId,
      required this.estimateDeliveryDateFrom,
      required this.estimateDeliveryTimeTo,
      required this.dealStatus,
      required this.maxOrdersPerUser,
      required this.quantity,
      required this.dealUrl,
      required this.product,
      required this.numberOfOrder});

  late final int dealId;
  late String dealTitle;
  late String dealDescription;
  late String startDate;
  late String endDate;
  late num costPrice;
  late num deliveryPrice;
  late num salePrice;
  late num totalPrice;
  late int categoryId;
  late String estimateDeliveryDateFrom;
  late String estimateDeliveryTimeTo;
  late String dealStatus;
  late int maxOrdersPerUser;
  late int quantity;
  late String dealUrl;
  late ProductModel product;
  late int numberOfOrder;

  DealModel.fromJson(Map<String, dynamic> json) {
    dealId = json['deal_id'] ?? 0;
    dealTitle = json['deal_title'] ?? "";
    dealDescription = json['deal_description'] ?? "";
    startDate = json['start_date'] ?? "";
    endDate = json['end_date'] ?? "";
    deliveryPrice = json['delivery_price'] ?? 0;
    salePrice = json['sale_price'] ?? 0;
    totalPrice = json['total_price'] ?? 0;
    categoryId = json['category_id'] ?? "";
    estimateDeliveryDateFrom = json['estimate_delivery_date_from'] ?? "";
    estimateDeliveryTimeTo = json['estimate_delivery_time_to'] ?? "";
    dealStatus = json['deal_status'] ?? "";
    maxOrdersPerUser = json['max_orders_per_user'] ?? 0;
    quantity = json['quantity'] ?? 0;
    dealUrl = json['deal_url'] ?? "";
    numberOfOrder = json['number_of_order'] ?? 0;
    product = ProductModel.fromJson(json['products']);
  }

  Map<String, dynamic> toJson({required int productId}) {
    final data = <String, dynamic>{};
    data['deal_title'] = dealTitle;
    data['deal_description'] = dealDescription;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['delivery_price'] = deliveryPrice;
    data['sale_price'] = salePrice;
    data['total_price'] = totalPrice;
    data['product_id'] = productId;
    data['category_id'] = categoryId;
    data['estimate_delivery_date_from'] = estimateDeliveryDateFrom;
    data['estimate_delivery_time_to'] = estimateDeliveryTimeTo;
    data['deal_status'] = dealStatus;
    data['max_orders_per_user'] = maxOrdersPerUser;
    data['quantity'] = quantity;
    data['deal_url'] = dealUrl;
    return data;
  }

  Map<String, dynamic> print() {
    final data = <String, dynamic>{};
    data['deal_id'] = dealId;
    data['deal_title'] = dealTitle;
    data['deal_description'] = dealDescription;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['delivery_price'] = deliveryPrice;
    data['sale_price'] = salePrice;
    data['total_price'] = totalPrice;
    data['product'] = product.print();
    data['category_id'] = categoryId;
    data['estimate_delivery_date_from'] = estimateDeliveryDateFrom;
    data['estimate_delivery_time_to'] = estimateDeliveryTimeTo;
    data['deal_status'] = dealStatus;
    data['max_orders_per_user'] = maxOrdersPerUser;
    data['quantity'] = quantity;
    data['deal_url'] = dealUrl;
    data["number_of_order"] = numberOfOrder;
    return data;
  }
}
