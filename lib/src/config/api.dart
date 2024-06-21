import 'package:dio/dio.dart';

abstract class Api {
  static Dio getInstance() {
    return Dio(
      BaseOptions(baseUrl: 'https://fake-api.tractian.com'),
    );
  }
}
