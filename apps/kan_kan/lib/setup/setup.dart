import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:kan_kan/integrations/supabase/supabase_client.dart';
import 'package:kan_kan/layer/address_layer.dart';
import 'package:kan_kan/layer/deal_data_layer.dart';

Future setup() async {
  await dotenv.load(fileName: ".env");

  await KanSupabase.connect();

  GetIt.I.registerSingleton<DealDataLayer>(DealDataLayer());
  GetIt.I.registerSingleton<AddressLayer>(AddressLayer());
}
