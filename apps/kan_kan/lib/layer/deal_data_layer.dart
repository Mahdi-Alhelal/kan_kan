import 'package:kan_kan/model/deal_model.dart';

class DealDataLayer {
  List<DealModel> deals = [];
  List<DealModel> activeDeals = [];
  List<DealModel> previosDeals = [];
  List<Map<String, dynamic>> categories = [];
  List<Map<String, dynamic>> filterCategories = [];
  List<DealModel> allDeals = [];

  DealModel getProductDeal({required int id}) {
    return deals.firstWhere((element) => element.product.productId == id);
  }

  DealModel findDeal(int id) {
    print("id");
    print(id);
    return userDealList.firstWhere((deal) => deal.dealId == id);
  }

  DealModel findOldDeal(int id) {
    return allDeals.firstWhere((deal) => deal.dealId == id);
    ;
  }

  getActiveDeals() {
    return activeDeals = deals.where((e) => e.dealStatus == "active").toList();
  }

  getPreviosDeals() {
    return previosDeals =
        deals.where((e) => e.dealStatus == "completed").toList();
  }
}
