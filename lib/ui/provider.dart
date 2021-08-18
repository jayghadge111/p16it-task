import 'package:dio/dio.dart';
import 'package:p16task/environment/env.dart';

abstract class IMasterProvider {
  Future get(String resourceUrl);
}

class MasterProvider implements IMasterProvider {
  Dio dio = Dio();

  String baseUrl = Env.API_URL;

  @override
  Future get(String resourceUrl) async {
    String url = baseUrl + resourceUrl;
    try {
      return await dio.get(
        url,
      );
    } catch (e) {
      return e.response;
    }
  }
}
