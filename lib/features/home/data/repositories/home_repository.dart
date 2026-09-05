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
    SlidersResponse? sliders;
    ServicesResponse? services;
    Failure? failure;

    try {
      sliders = await remote.getSliders();
    } on DioException catch (e) {
      failure = ServerFailure.fromDioError(e);
    } catch (e) {
      failure = ServerFailure(e.toString());
    }

    try {
      services = await remote.getServices(perPage: perPage);
    } on DioException catch (e) {
      failure = ServerFailure.fromDioError(e);
    } catch (e) {
      failure = ServerFailure(e.toString());
    }

    if (sliders == null && services == null && failure != null) {
      return (sliders: null, services: null, failure: failure);
    }

    return (sliders: sliders, services: services, failure: null);
  }
}
