import 'package:kan_kan_admin/model/factory_model.dart';

class FactoryDataLayer {
  List<FactoryModel> factories = [];

 FactoryModel getFactory({required int id}) {
 return   factories.firstWhere((factory) => factory.factoryId == id);
  }
}
