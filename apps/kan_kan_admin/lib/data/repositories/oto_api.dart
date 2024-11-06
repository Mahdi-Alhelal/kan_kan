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
    } catch (e) {
      throw ("error in get key $e");
    }
  }

  static sendNotification({required OtoModel order}) async {
    try {
      await dio.post(
        "$baseUrl$createShipment",
        data: order.toJson(),
        options: Options(headers: {
          "Authorization": "Bearer $accessToken",
          'Content-Type': 'application/json'
        }),
      );
    } catch (e) {
      throw ("in send notification $e");
    }
  }
}
