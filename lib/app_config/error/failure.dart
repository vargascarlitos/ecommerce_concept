
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

abstract interface class Failure extends Equatable {
  final String message;
  final DioException? error;
  const Failure(this.message, {this.error});
}


class ServerFailure extends Failure {
  const ServerFailure(super.message, {super.error});

  @override
  List<Object?> get props => [message, error];
}