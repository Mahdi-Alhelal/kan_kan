import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:kan_kan_admin/layer/category_data_layer.dart';
import 'package:kan_kan_admin/local_data/status_list.dart';
import 'package:kan_kan_admin/integrations/supabase/supabase_client.dart';
import 'package:kan_kan_admin/layer/deal_data_layer.dart';
import 'package:kan_kan_admin/layer/factory_data_layer.dart';
import 'package:kan_kan_admin/layer/order_data_layer.dart';
import 'package:kan_kan_admin/layer/product_data_layer.dart';
import 'package:kan_kan_admin/layer/user_layer.dart';

Future setup() async {
  await dotenv.load(fileName: ".env");
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
  ]);
  await KanSupabase.connect();

  GetIt.I.registerSingleton<UserLayer>(UserLayer());
  GetIt.I.registerSingleton<ProductDataLayer>(ProductDataLayer());
  GetIt.I.registerSingleton<FactoryDataLayer>(FactoryDataLayer());
  GetIt.I.registerSingleton<DealDataLayer>(DealDataLayer());
  GetIt.I.registerSingleton<OrderDataLayer>(OrderDataLayer());
  GetIt.I.registerSingleton<DropMenuList>(DropMenuList());
  GetIt.I.registerSingleton<CategoryDataLayer>(CategoryDataLayer());
}
