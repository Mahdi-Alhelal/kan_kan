class OrderModel {
  late String orderNumber;
  late String customerName;
  late num price;
  late String product;
  late String orderDate;
  late String status;
  late String shipmentStatus;

  OrderModel({
    required this.customerName,
    required this.orderDate,
    required this.orderNumber,
    required this.price,
    required this.product,
    required this.shipmentStatus,
    required this.status,
  });
}
