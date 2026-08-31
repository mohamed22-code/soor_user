import 'package:dio/dio.dart';
import '../../../../core/network/dio/dio_api_manager.dart';
import '../../../home/data/models/service_model.dart';
import '../models/work_period_model.dart';
import '../models/hour_price_model.dart';
import '../models/booking_request.dart';

abstract class ServicesRemoteDataSource {
  Future<ServicesResponse> getAllServices({int perPage = 1000});

  Future<WorkPeriodsResponse> getWorkPeriods();

  Future<HourPriceModel> getHourPrice();

  Future<BookingResponse> createBooking(BookingRequest request);
}

class ServicesRemoteDataSourceImpl implements ServicesRemoteDataSource {
  final Dio dio;

  ServicesRemoteDataSourceImpl({Dio? dio}) : dio = dio ?? DioApiManager().dio;

  @override
  Future<ServicesResponse> getAllServices({int perPage = 1000}) async {
    final res = await dio.get(
      '/services',
      queryParameters: {'per_page': perPage},
    );
    return ServicesResponse.fromJson(res.data);
  }

  @override
  Future<WorkPeriodsResponse> getWorkPeriods() async {
    final res = await dio.get('/work-periods');
    return WorkPeriodsResponse.fromJson(res.data);
  }

  @override
  Future<HourPriceModel> getHourPrice() async {
    final res = await dio.get('/hour_price');
    return HourPriceModel.fromJson(res.data);
  }

  @override
  Future<BookingResponse> createBooking(BookingRequest request) async {
    final res = await dio.post('/bookings', data: request.toJson());
    return BookingResponse.fromJson(res.data);
  }
}
