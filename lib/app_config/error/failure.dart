
import 'package:dio/dio.dart';

abstract interface class Failure {
  final String message;
  final DioException? error;
  const Failure(this.message, {this.error});
}


class ServerFailure extends Failure {
  const ServerFailure(super.message, {super.error});
}