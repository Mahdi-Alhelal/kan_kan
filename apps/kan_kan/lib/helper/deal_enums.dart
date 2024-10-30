enum DealEnums { completed, active, pending, closed, private }

class EnumDealsHelper {
  static String dealStatusToString(DealEnums status) {
    switch (status) {
      case DealEnums.completed:
        return 'completed';
      case DealEnums.closed:
        return 'closed';
      case DealEnums.active:
        return 'active';
      case DealEnums.pending:
        return 'pending';
      case DealEnums.private:
        return 'private';

      default:
        return 'private';
    }
  }

  static DealEnums stringToDealStatus(String status) {
    switch (status) {
      case 'completed':
        return DealEnums.completed;
      case 'closed':
        return DealEnums.closed;
      case 'active':
        return DealEnums.active;
      case 'pending':
        return DealEnums.pending;
      case 'private':
        return DealEnums.private;
      default:
        return DealEnums.private;
    }
  }
}

class LocalizedDealsEnums {
  static const Map<DealEnums, Map<String, String>> dealStatusNames = {
    DealEnums.completed: {
      'en': 'Completed',
      'ar': 'مكتمل',
      'zh': '完成',
    },
    DealEnums.active: {
      'en': 'Active',
      'ar': 'نشط',
      'zh': '活跃',
    },
    DealEnums.pending: {
      'en': 'Pending',
      'ar': 'معلق',
      'zh': '待处理',
    },
    DealEnums.closed: {
      'en': 'Closed',
      'ar': 'مغلق',
      'zh': '关闭',
    },
    DealEnums.private: {
      'en': 'Private',
      'ar': 'خاص',
      'zh': '私人',
    },
  };

  static String getDealsStatusName(DealEnums status, String languageCode) {
    return dealStatusNames[status]?[languageCode] ??
        dealStatusNames[status]!['en']!;
  }
  
}
