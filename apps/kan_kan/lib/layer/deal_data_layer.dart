import 'package:kan_kan/model/deal_model.dart';

class DealDataLayer {
  List<DealModel> deals = [];
  DealModel getProductDeal({required int id}) {
    return deals.firstWhere((element) => element.product.productId == id);
  }

  DealModel findDeal(int id) {
    return deals.firstWhere((deal) => deal.dealId == id);
  }
}
