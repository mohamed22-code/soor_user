import 'package:dio/dio.dart';
import '../../../../core/network/dio/dio_api_manager.dart';
import '../models/slider_model.dart';
import '../models/service_model.dart';

abstract class HomeRemoteDataSource {
  Future<SlidersResponse> getSliders();

  Future<ServicesResponse> getServices({int perPage = 5});
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final Dio dio;

  HomeRemoteDataSourceImpl({Dio? dio}) : dio = dio ?? DioApiManager().dio;

  @override
  Future<SlidersResponse> getSliders() async {
    final res = await dio.get('/sliders');
    return SlidersResponse.fromJson(res.data);
  }

  @override
  Future<ServicesResponse> getServices({int perPage = 5}) async {
    final res = await dio.get(
      '/services',
      queryParameters: {'per_page': perPage},
    );
    return ServicesResponse.fromJson(res.data);
  }
}
