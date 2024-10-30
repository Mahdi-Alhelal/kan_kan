enum PaymentEnums {
  paid,
  refund,
}

class EnumPaymentHelper {
  static String orderStatusToString(PaymentEnums status) {
    switch (status) {
      case PaymentEnums.paid:
        return 'paid';
      case PaymentEnums.refund:
        return 'refund';
      default:
        return 'unknown';
    }
  }

  static PaymentEnums stringToOrderStatus(String status) {
    switch (status) {
      case 'paid':
        return PaymentEnums.paid;
      case 'refund':
        return PaymentEnums.refund;
      default:
        return PaymentEnums.paid;
    }
  }
}

class LocalizedPaymentEnums {
  static const Map<PaymentEnums, Map<String, String>> paymentStatusNames = {
    PaymentEnums.paid: {
      'en': 'Paid',
      'ar': 'مدفوع',
      'zh': '已支付',
    },
    PaymentEnums.refund: {
      'en': 'Refund',
      'ar': 'مسترد',
      'zh': '退款',
    },
  };

  static String getPaymentStatusName(PaymentEnums status, String languageCode) {
    return paymentStatusNames[status]?[languageCode] ??
        paymentStatusNames[status]!['en']!;
  }
}
