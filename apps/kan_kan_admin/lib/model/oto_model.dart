class OtoModel {
  OtoModel({
    required this.orderId,
    required this.amount,
    required this.customer,
    required this.item,
  });
  late final String orderId;
  late final String createShipment = "true";
  late final int deliveryOptionId = 1;
  late final String paymentMethod = 'paid';
  late final int amount;
  late final int amountDue = 0;
  late final String currency = "SAR";
  final String senderName = "Kan Kan";
  late final Customer customer;
  late final Item item;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['orderId'] = orderId;
    data['createShipment'] = createShipment;
    data['deliveryOptionId'] = deliveryOptionId;
    data['payment_method'] = paymentMethod;
    data['amount'] = amount;
    data['amount_due'] = amountDue;
    data['currency'] = currency;
    data['senderName'] = senderName;
    data['customer'] = customer.toJson();
    data['items'] = [item.toJson()];
    return data;
  }
}

class Customer {
  Customer({
    required this.name,
    required this.email,
    required this.mobile,
    required this.address,
    required this.city,
  });
  late final String name;
  late final String email;
  late final String mobile;
  late final String address;
  late final String city;
  late final String country = "SA";

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['mobile'] = mobile;
    data['address'] = address;
    data['city'] = city;
    data['country'] = country;
    return data;
  }
}

class Item {
  Item(
      {required this.productId,
      required this.name,
      required this.price,
      required this.sku,
      required this.quantity});
  late final int productId;
  late final String name;
  late final int price;
  late final int quantity;
  late final String sku;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['productId'] = productId;
    data['name'] = name;
    data['price'] = price;
    data['quantity'] = quantity;
    data['sku'] = sku;
    return data;
  }
}
