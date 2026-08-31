import 'package:dio/dio.dart';
import '../../../../core/error/failures.dart';
import '../datasources/bookings_remote_datasource.dart';
import '../models/booking_model.dart';
import '../models/rating_criteria_model.dart';

class BookingsRepository {
  final BookingsRemoteDataSource remote;

  BookingsRepository({BookingsRemoteDataSource? remote})
    : remote = remote ?? BookingsRemoteDataSourceImpl();

  Future<(BookingsPaginatedResponse?, Failure?)> getBookings({
    int page = 1,
  }) async {
    try {
      final res = await remote.getBookings(page: page);
      return (res, null);
    } on DioException catch (e) {
      return (null, ServerFailure.fromDioError(e));
    } catch (e) {
      return (null, ServerFailure(e.toString()));
    }
  }

  Future<(RatingCriteriaResponse?, Failure?)> getRatingCriteria() async {
    try {
      final res = await remote.getRatingCriteria();
      return (res, null);
    } on DioException catch (e) {
      return (null, ServerFailure.fromDioError(e));
    } catch (e) {
      return (null, ServerFailure(e.toString()));
    }
  }

  Future<(Map<String, dynamic>?, Failure?)> rateGuard({
    required int bookingId,
    required Map<String, int> ratings,
  }) async {
    try {
      final res = await remote.rateGuard(
        bookingId: bookingId,
        ratings: ratings,
      );
      final status = res['status'];
      if (status == false)
        return (
          null,
          ServerFailure(res['message']?.toString() ?? 'فشل التقييم'),
        );
      return (res, null);
    } on DioException catch (e) {
      return (null, ServerFailure.fromDioError(e));
    } catch (e) {
      return (null, ServerFailure(e.toString()));
    }
  }
}
