import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object?> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);

  factory ServerFailure.fromDioError(DioException e) {
    if (e.response != null) {
      final data = e.response?.data;
      String msg = 'حدث خطأ غير متوقع';
      if (data is Map<String, dynamic>) {
        msg =
            data['message']?.toString() ??
            data['msg']?.toString() ??
            data['error']?.toString() ??
            msg;
        // validation errors: {errors: {phone:[...]}}
        if (data['errors'] is Map) {
          final errors = data['errors'] as Map;
          final firstKey = errors.keys.first;
          final firstVal = errors[firstKey];
          if (firstVal is List && firstVal.isNotEmpty) {
            msg = firstVal.first.toString();
          }
        }
      } else if (data is String) {
        msg = data;
      }
      return ServerFailure(msg);
    } else {
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return const ServerFailure('انتهت مهلة الاتصال، حاول مرة أخرى');
        case DioExceptionType.connectionError:
          return const ServerFailure('لا يوجد اتصال بالإنترنت');
        default:
          return ServerFailure(e.message ?? 'حدث خطأ غير متوقع');
      }
    }
  }
}

class CacheFailure extends Failure {
  const CacheFailure(super.message);
}
