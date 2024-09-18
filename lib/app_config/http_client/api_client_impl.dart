import 'package:async/src/result/result.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce_concept/app_config/http_client/api_client.dart';

class ApiClientImpl implements APIClient {
  final Dio _dio;

  ApiClientImpl({required Dio dio}) : _dio = dio;

  @override
  Future<Result<T>> getRequest<T>(String url,
      {required ResponseConverter<T> converter,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers,
      bool isIsolate = true}) async {
    try {
      final response = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: Options(
          headers: headers,
        ),
      );
      return Result.value(converter(response.data));
    } catch (e) {
      return Result.error(e);
    }
  }
}
