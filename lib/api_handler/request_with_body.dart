import 'package:dio/dio.dart';
import 'package:front_syndic/api_handler/credential.dart';
import 'package:front_syndic/api_handler/dio.dart';

Future<Response> requestWithBody({
  required String url,
  required String method,
  required String body,
}) async {
  var dio = DioService.instance.dio;
  return await dio.request(
    url,
    data: body,
    options: Options(
      method: method,
      headers: {
        'Authorization': Credential.instance.token,
      },
    ),
  );
}