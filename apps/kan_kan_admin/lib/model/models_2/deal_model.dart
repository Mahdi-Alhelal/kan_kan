import 'package:kan_kan_admin/model/product_model.dart';

class DealModel {
  DealModel({
    required this.dealId,
    required this.dealTitle,
    required this.dealDescription,
    required this.startDate,
    required this.endDate,
    required this.costPrice,
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
  });
  late final int dealId;
  late  String dealTitle;
  late  String dealDescription;
  late  String startDate;
  late  String endDate;
  late  num costPrice;
  late  num deliveryPrice;
  late  num salePrice;
  late  num totalPrice;
  late  int categoryId;
  late  String estimateDeliveryDateFrom;
  late  String estimateDeliveryTimeTo;
  late  String dealStatus;
  late  int maxOrdersPerUser;
  late  int quantity;
  late  String dealUrl;
  late  ProductModel product;

  DealModel.fromJson(Map<String, dynamic> json) {
    dealId = json['deal_id'] ?? 0;
    dealTitle = json['deal_title'] ?? "";
    dealDescription = json['deal_description'] ?? "";
    startDate = json['start_date'] ?? "";
    endDate = json['end_date'] ?? "";
    costPrice = json['cost_price'] ?? 0;
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
 
    product = ProductModel.fromJson(json['products']);
  }

  Map<String, dynamic> toJson({required int productId}) {
    final _data = <String, dynamic>{};
    _data['deal_id'] = dealId;
    _data['deal_title'] = dealTitle;
    _data['deal_description'] = dealDescription;
    _data['start_date'] = startDate;
    _data['end_date'] = endDate;
    _data['cost_price'] = costPrice;
    _data['delivery_price'] = deliveryPrice;
    _data['sale_price'] = salePrice;
    _data['total_price'] = totalPrice;
    _data['product_id'] = productId;
    _data['category_id'] = categoryId;
    _data['estimate_delivery_date_from'] = estimateDeliveryDateFrom;
    _data['estimate_delivery_time_to'] = estimateDeliveryTimeTo;
    _data['deal_status'] = dealStatus;
    _data['max_orders_per_user'] = maxOrdersPerUser;
    _data['quantity'] = quantity;
    _data['deal_url'] = dealUrl;
    return _data;
  }



  
  Map<String, dynamic> print() {
    final _data = <String, dynamic>{};
    _data['deal_id'] = dealId;
    _data['deal_title'] = dealTitle;
    _data['deal_description'] = dealDescription;
    _data['start_date'] = startDate;
    _data['end_date'] = endDate;
    _data['cost_price'] = costPrice;
    _data['delivery_price'] = deliveryPrice;
    _data['sale_price'] = salePrice;
    _data['total_price'] = totalPrice;
    _data['product'] = product.print();
    _data['category_id'] = categoryId;
    _data['estimate_delivery_date_from'] = estimateDeliveryDateFrom;
    _data['estimate_delivery_time_to'] = estimateDeliveryTimeTo;
    _data['deal_status'] = dealStatus;
    _data['max_orders_per_user'] = maxOrdersPerUser;
    _data['quantity'] = quantity;
    _data['deal_url'] = dealUrl;
    
    return _data;
  }
}