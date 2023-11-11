import 'package:contatos_flutter/enum/base_url_enum.dart';
import 'package:dio/dio.dart';

class DioInterceptor extends Interceptor {
  DioInterceptor(this.baseUrl);

  final BaseUrlEnum baseUrl;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    headersByBaseUrl(options);

    print('REQUEST[${options.method}] => PATH: ${options.path}');
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print(
        'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException ex, ErrorInterceptorHandler handler) {
    print(
        'ERROR[${ex.response?.statusCode}] => PATH: ${ex.requestOptions.path}');
    super.onError(ex, handler);
  }

  void headersByBaseUrl(RequestOptions options) {
    switch (baseUrl) {
      case BaseUrlEnum.BACK4APP:
        options.headers["X-Parse-Application-Id"] = baseUrl.getID();
        options.headers["X-Parse-REST-API-Key"] = baseUrl.getApiKey();
        break;
      default:
       break;
    }
  }
}
