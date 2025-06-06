import 'package:dio/dio.dart';
import 'package:incident_tracker/conf/dio/errorInterceptor.dart';
import 'package:incident_tracker/conf/dio/headerInterceptor.dart';

class DioService {
  DioService._privateConstructor();
  static final DioService instance = DioService._privateConstructor();

  Dio dio = Dio();

  void setup() {
    dio.options.baseUrl = 'http://197.243.1.84:3020';

    dio.options.connectTimeout = Duration(seconds: 15);
    dio.options.receiveTimeout = Duration(seconds: 15);

    dio.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    dio.interceptors.add(ErrorInterceptor());
    dio.interceptors.add(HeaderInterceptor());
  }
}
