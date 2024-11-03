import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kan_kan_admin/model/oto_model.dart';

abstract class OtoApi {
  static const baseUrl = "https://api.tryoto.com";
  static const refresh = "/rest/v2/refreshToken";
  static const createShipment = '/rest/v2/createOrder';
  static late String accessToken;
  static final dio = Dio();

  static getKey() async {
    try {
      final response = await dio.post("$baseUrl$refresh",
          data: {"refresh_token": dotenv.env["refresh_token"]});
      accessToken = response.data["access_token"];
      print(accessToken);
    } catch (e) {
      throw ("error in get key $e");
    }
  }

  static sendNotification({required OtoModel order}) async {
    final response;
    try {
      print("send");
      response = await dio.post(
        "$baseUrl$createShipment",
        data: order.toJson(),
        options: Options(headers: {
          "Authorization": "Bearer $accessToken",
          'Content-Type': 'application/json'
        }),
      );
      print(response["message"]);
    } on DioException catch (e) {
      print(e.message);
    } catch (e) {
      print("in send notification $e");
    }
  }
}
