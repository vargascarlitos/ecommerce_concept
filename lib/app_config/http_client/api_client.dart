import 'package:async/async.dart';

typedef ResponseConverter<T> = T Function(dynamic response);

abstract interface class APIClient {
  Future<Result<T>> getRequest<T>(
    String url, {
    required ResponseConverter<T> converter,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    bool isIsolate = true,
  });


}
