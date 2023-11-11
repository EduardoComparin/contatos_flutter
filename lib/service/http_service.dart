import 'package:contatos_flutter/enum/base_url_enum.dart';
import 'package:contatos_flutter/service/interceptor.dart';
import 'package:dio/dio.dart';

class httpService{
  httpService({
    this.baseUrl = BaseUrlEnum.BACK4APP,
    this.responseType= ResponseType.json,
    this.contentType='application/json'
  });

final BaseUrlEnum baseUrl;
final ResponseType responseType;
final String contentType;


Dio getDio(){
  final Dio dio = Dio();

  dio.options.baseUrl= baseUrl.getUrl();
  dio.options.connectTimeout = const Duration(seconds: 30);
  dio.options.receiveTimeout = const Duration(minutes:3);
  dio.options.responseType = responseType;
  dio.options.contentType = contentType;
  dio.interceptors.add(DioInterceptor(baseUrl));

  return dio;
}
}