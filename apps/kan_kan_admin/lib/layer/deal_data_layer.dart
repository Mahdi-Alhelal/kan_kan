import 'package:kan_kan_admin/model/deal_model.dart';

class DealDataLayer {
  List<DealModel> deals = [];
  DealModel getProductDeal({required int id}) {
    return deals.firstWhere((element) => element.product.productId == id);
  }
}
