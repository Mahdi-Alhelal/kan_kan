class OrderModel {
  OrderModel(
      {required this.orderId,
      required this.dealId,
      required this.userId,
      required this.orderDate,
      required this.orderStatus,
      required this.trackingNumber,
      required this.trackingCompany,
      required this.quantity,
      required this.amount,
      required this.address,
      required this.paymentStatus});
  late int orderId;
  late int dealId;
  late String userId;
  late String orderDate;
  late String orderStatus;
  late String trackingNumber;
  late String trackingCompany;
  late int quantity;
  late num amount;
  late String address;
  late String paymentStatus;
  OrderModel.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'] ?? 0;
    dealId = json['deal_id'] ?? 0;
    userId = json['user_id'] ?? "";
    orderDate = json['order_date'] ?? "";
    orderStatus = json['order_status'] ?? "";
    trackingNumber = json['tracking_number'] ?? "";
    trackingCompany = json['tracking_company'] ?? "";
    quantity = json['quantity'] ?? 0;
    amount = json['amount'] ?? 0;
    address = json['address'] ?? "";
    paymentStatus = json['payment_status'] ?? "failed";
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['order_id'] = orderId;
    data['deal_id'] = dealId;
    data['user_id'] = userId;
    data['order_date'] = orderDate;
    data['order_status'] = orderStatus;
    data['tracking_number'] = trackingNumber;
    data['tracking_company'] = trackingCompany;
    data['quantity'] = quantity;
    data['amount'] = amount;
    data['address'] = address;
    data['payment_status'] = paymentStatus;
    return data;
  }
}
