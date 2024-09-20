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
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  Result<T> _handleError<T>(DioException e) {
    switch (e.type) {
      case DioExceptionType.badCertificate:
        return Result.error('Bad certificate, please try again');
      case DioExceptionType.receiveTimeout:
        return Result.error('Receive timeout, please try again');
      case DioExceptionType.badResponse:
        return Result.error('Response error, please try again');
      case DioExceptionType.sendTimeout:
        return Result.error('Send timeout, please try again');
      case DioExceptionType.cancel:
        return Result.error('Request cancelled');
      case DioExceptionType.unknown:
        return Result.error('Internal server error, please try again');
      case DioExceptionType.connectionTimeout:
        return Result.error('Connection timeout, please try again');
      case DioExceptionType.connectionError:
        return Result.error('Connection error, please try again');
    }
  }
}
