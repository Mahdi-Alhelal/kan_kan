import 'package:kan_kan/model/deal_model.dart';

class DealDataLayer {
  List<DealModel> deals = [];
  List<DealModel> activeDeals = [];
  List<DealModel> previosDeals = [];

  DealModel getProductDeal({required int id}) {
    return deals.firstWhere((element) => element.product.productId == id);
  }

  DealModel findDeal(int id) {
    return deals.firstWhere((deal) => deal.dealId == id);
  }

  getActiveDeals() {
    return activeDeals = deals.where((e) => e.dealStatus == "active").toList();
  }

  getPreviosDeals() {
    return previosDeals =
        deals.where((e) => e.dealStatus == "completed").toList();
  }
}
