import 'package:dio/dio.dart';
import '../../../../core/error/failures.dart';
import '../../../home/data/models/service_model.dart';
import '../datasources/services_remote_datasource.dart';
import '../models/work_period_model.dart';
import '../models/hour_price_model.dart';
import '../models/booking_request.dart';

class ServicesRepository {
  final ServicesRemoteDataSource remote;

  ServicesRepository({ServicesRemoteDataSource? remote})
    : remote = remote ?? ServicesRemoteDataSourceImpl();

  Future<(ServicesResponse?, Failure?)> getAllServices({
    int perPage = 1000,
  }) async {
    try {
      final res = await remote.getAllServices(perPage: perPage);
      return (res, null);
    } on DioException catch (e) {
      return (null, ServerFailure.fromDioError(e));
    } catch (e) {
      return (null, ServerFailure(e.toString()));
    }
  }

  Future<(WorkPeriodsResponse?, Failure?)> getWorkPeriods() async {
    try {
      final res = await remote.getWorkPeriods();
      return (res, null);
    } on DioException catch (e) {
      return (null, ServerFailure.fromDioError(e));
    } catch (e) {
      return (null, ServerFailure(e.toString()));
    }
  }

  Future<(HourPriceModel?, Failure?)> getHourPrice() async {
    try {
      final res = await remote.getHourPrice();
      return (res, null);
    } on DioException catch (e) {
      return (null, ServerFailure.fromDioError(e));
    } catch (e) {
      return (null, ServerFailure(e.toString()));
    }
  }

  Future<(BookingResponse?, Failure?)> createBooking(BookingRequest req) async {
    try {
      final res = await remote.createBooking(req);
      if (res.status == false)
        return (null, ServerFailure(res.message ?? 'فشل إنشاء الحجز'));
      return (res, null);
    } on DioException catch (e) {
      return (null, ServerFailure.fromDioError(e));
    } catch (e) {
      return (null, ServerFailure(e.toString()));
    }
  }
}
