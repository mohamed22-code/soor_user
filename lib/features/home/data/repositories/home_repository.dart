import 'package:dio/dio.dart';
import '../../../../core/error/failures.dart';
import '../datasources/home_remote_datasource.dart';
import '../models/slider_model.dart';
import '../models/service_model.dart';

class HomeRepository {
  final HomeRemoteDataSource remote;

  HomeRepository({HomeRemoteDataSource? remote})
    : remote = remote ?? HomeRemoteDataSourceImpl();

  Future<(SlidersResponse?, Failure?)> getSliders() async {
    try {
      final res = await remote.getSliders();
      return (res, null);
    } on DioException catch (e) {
      return (null, ServerFailure.fromDioError(e));
    } catch (e) {
      return (null, ServerFailure(e.toString()));
    }
  }

  Future<(ServicesResponse?, Failure?)> getServices({int perPage = 5}) async {
    try {
      final res = await remote.getServices(perPage: perPage);
      return (res, null);
    } on DioException catch (e) {
      return (null, ServerFailure.fromDioError(e));
    } catch (e) {
      return (null, ServerFailure(e.toString()));
    }
  }

  Future<
    ({SlidersResponse? sliders, ServicesResponse? services, Failure? failure})
  >
  getHomeData({int perPage = 5}) async {
    try {
      final results = await Future.wait([
        remote.getSliders(),
        remote.getServices(perPage: perPage),
      ]);
      return (
        sliders: results[0] as SlidersResponse,
        services: results[1] as ServicesResponse,
        failure: null,
      );
    } on DioException catch (e) {
      return (
        sliders: null,
        services: null,
        failure: ServerFailure.fromDioError(e),
      );
    } catch (e) {
      return (
        sliders: null,
        services: null,
        failure: ServerFailure(e.toString()),
      );
    }
  }
}
