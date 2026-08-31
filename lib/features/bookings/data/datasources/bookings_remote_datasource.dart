import 'package:dio/dio.dart';
import '../../../../core/network/dio/dio_api_manager.dart';
import '../models/booking_model.dart';
import '../models/rating_criteria_model.dart';

abstract class BookingsRemoteDataSource {
  Future<BookingsPaginatedResponse> getBookings({int page = 1});

  Future<RatingCriteriaResponse> getRatingCriteria();

  Future<Map<String, dynamic>> rateGuard({
    required int bookingId,
    required Map<String, int> ratings,
  });
}

class BookingsRemoteDataSourceImpl implements BookingsRemoteDataSource {
  final Dio dio;

  BookingsRemoteDataSourceImpl({Dio? dio}) : dio = dio ?? DioApiManager().dio;

  @override
  Future<BookingsPaginatedResponse> getBookings({int page = 1}) async {
    final res = await dio.get('/bookings', queryParameters: {'page': page});
    return BookingsPaginatedResponse.fromJson(res.data);
  }

  @override
  Future<RatingCriteriaResponse> getRatingCriteria() async {
    final res = await dio.get('/rating-criteria');
    return RatingCriteriaResponse.fromJson(res.data);
  }

  @override
  Future<Map<String, dynamic>> rateGuard({
    required int bookingId,
    required Map<String, int> ratings,
  }) async {
    final Map<String, dynamic> stringRatings = ratings.map(
      (k, v) => MapEntry(k, v),
    );
    final res = await dio.post(
      '/bookings/$bookingId/rate-guard',
      data: {'ratings': stringRatings},
    );
    if (res.data is Map<String, dynamic>)
      return res.data as Map<String, dynamic>;
    return {'status': true, 'message': 'تم التقييم'};
  }
}
