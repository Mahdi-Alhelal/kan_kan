class OrderModel {
  OrderModel(
      {required this.orderId,
      required this.dealId,
      required this.userId,
      required this.orderDate,
      required this.orderStatus,
      this.trackingNumber,
      this.trackingCompany,
      required this.quantity,
      required this.amount,
      required this.address});
  late final int orderId;
  late final int dealId;
  late final String userId;
  late final String orderDate;
  late final String orderStatus;
  late String? trackingNumber;
  late String? trackingCompany;
  late final int quantity;
  late final num amount;
  late final String address;

  OrderModel.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    dealId = json['deal_id'];
    userId = json['user_id'];
    orderDate = json['order_date'];
    orderStatus = json['order_status'];
    trackingNumber = json['tracking_number'];
    trackingCompany = json['tracking_company'];
    quantity = json['quantity'];
    amount = json['amount'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['order_id'] = orderId;
    _data['deal_id'] = dealId;
    _data['user_id'] = userId;
    _data['order_date'] = orderDate;
    _data['order_status'] = orderStatus;
    _data['tracking_number'] = trackingNumber;
    _data['tracking_company'] = trackingCompany;
    _data['quantity'] = quantity;
    _data['amount'] = amount;
    _data['address'] = address;

    return _data;
  }
}
