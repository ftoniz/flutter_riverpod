import 'package:dio/dio.dart';
import 'package:ft_flutter_riverpod/repository/base/app_interceptors.dart';

class AppNetwork {
  final _dio = _createDio();

  Dio get dio => _dio;

  static Dio _createDio() {
    var dio = Dio(
      BaseOptions(
        baseUrl: 'https://api.publicapis.org/',
        receiveTimeout: const Duration(seconds: 15),
        connectTimeout: const Duration(seconds: 15),
        sendTimeout: const Duration(seconds: 15),
      ),
    );

    dio.interceptors.addAll({
      AppInterceptors(dio),
    });

    dio.httpClientAdapter = HttpClientAdapter();

    return dio;
  }

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    var response = await _dio.get<T>(path, queryParameters: queryParameters);
    return response;
  }

  Future<Response<T>> post<T>(
    String path, {
    Object? data,
  }) async {
    var response = await _dio.post<T>(path, data: data);
    return response;
  }

  Future<Response<T>> put<T>(
    String path, {
    Object? data,
  }) async {
    var response = await _dio.put<T>(path, data: data);
    return response;
  }

  Future<Response<T>> delete<T>(String path) async {
    var response = await _dio.delete<T>(path);
    return response;
  }
}
