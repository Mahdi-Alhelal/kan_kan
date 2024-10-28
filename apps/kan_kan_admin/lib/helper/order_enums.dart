enum OrderStatus {
  pending,
  processing,
  inChina,
  inTransit,
  inSaudi,
  withShipmentCompany,
  completed,
  canceled,
}

class EnumOrderHelper {
  static String orderStatusToString(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return 'pending';
      case OrderStatus.processing:
        return 'processing';
      case OrderStatus.inChina:
        return 'inChina';
      case OrderStatus.inTransit:
        return 'inTransit';
      case OrderStatus.inSaudi:
        return 'inSaudi';
      case OrderStatus.withShipmentCompany:
        return 'withShipmentCompany';
      case OrderStatus.completed:
        return 'completed';
      case OrderStatus.canceled:
        return 'canceled';
      default:
        return 'unknown';
    }
  }

  static OrderStatus stringToOrderStatus(String status) {
    switch (status) {
      case 'pending':
        return OrderStatus.pending;
      case 'processing':
        return OrderStatus.processing;
      case 'inChina':
        return OrderStatus.inChina;
      case 'inTransit':
        return OrderStatus.inTransit;
      case 'inSaudi':
        return OrderStatus.inSaudi;
      case 'withShipmentCompany':
        return OrderStatus.withShipmentCompany;
      case 'completed':
        return OrderStatus.completed;
      case 'canceled':
        return OrderStatus.canceled;
      default:
        throw ArgumentError('Invalid order status: $status');
    }
  }
}

class LocalizedEnums {
  static const Map<OrderStatus, Map<String, String>> orderStatusNames = {
    OrderStatus.pending: {
      'en': 'Pending',
      'ar': 'قيد الانتظار',
      'zh': '待处理',
    },
    OrderStatus.processing: {
      'en': 'Processing',
      'ar': 'جاري المعالجة',
      'zh': '处理中',
    },
    OrderStatus.inChina: {
      'en': 'In China',
      'ar': 'في الصين',
      'zh': '在中国',
    },
    OrderStatus.inTransit: {
      'en': 'In Transit',
      'ar': 'في الطريق',
      'zh': '运输中',
    },
    OrderStatus.inSaudi: {
      'en': 'In Saudi',
      'ar': 'في السعودية',
      'zh': '在沙特',
    },
    OrderStatus.withShipmentCompany: {
      'en': 'With Shipment Company',
      'ar': 'مع شركة الشحن',
      'zh': '在物流公司',
    },
    OrderStatus.completed: {
      'en': 'Completed',
      'ar': 'مكتمل',
      'zh': '已完成',
    },
    OrderStatus.canceled: {
      'en': 'Canceled',
      'ar': 'ملغى',
      'zh': '已取消',
    },
  };

  static String getOrderStatusName(OrderStatus status, String languageCode) {
    return orderStatusNames[status]?[languageCode] ??
        orderStatusNames[status]!['en']!;
  }
}
