import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kan_kan_admin/integrations/supabase/supabase_client.dart';

Future setup() async{
  await dotenv.load(fileName: ".env");
   SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
  ]);
 await KanSupabase.connect();
}
