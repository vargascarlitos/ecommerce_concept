import 'package:dio/dio.dart';
import 'package:ecommerce_concept/app_config/http_client/api_client.dart';
import 'package:ecommerce_concept/app_config/http_client/api_client_impl.dart';
import 'package:ecommerce_concept/features/product/data/datasource/product_remote_datasource.dart';
import 'package:ecommerce_concept/features/product/data/repositories/product_repository_impl.dart';
import 'package:ecommerce_concept/features/product/domain/repositories/product_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:talker/talker.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';
import 'dart:developer' as developer;

final GetIt sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton<Interceptor>(
    () => TalkerDioLogger(
      talker: Talker(
        logger: TalkerLogger(
          settings: TalkerLoggerSettings(
            enableColors: false,
          ),
          output: (String message) {
            return message.split('\n').forEach(developer.log);
          },
        ),
      ),
      settings: const TalkerDioLoggerSettings(
        printRequestHeaders: true,
        printResponseHeaders: true,
        printResponseMessage: true,
        printRequestData: true,
        printResponseData: true,
      ),
    ),
  );

  sl.registerLazySingleton(
    () => Dio(
      BaseOptions(
        baseUrl: 'https://dummyjson.com/',
        contentType: 'application/json',
        connectTimeout: const Duration(milliseconds: 4000),
        receiveTimeout: const Duration(milliseconds: 4000),
      ),
    )..interceptors.add(
        sl<Interceptor>(),
      ),
  );

  sl.registerLazySingleton<APIClient>(
    () => ApiClientImpl(
      dio: sl(),
    ),
  );

  sl.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDatasourceImpl(
      apiClient: sl(),
    ),
  );

  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(
      productRemoteDataSource: sl(),
    ),
  );
}
