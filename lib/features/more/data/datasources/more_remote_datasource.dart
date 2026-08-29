import 'package:dio/dio.dart';
import '../../../../core/network/dio/dio_api_manager.dart';
import '../models/terms_model.dart';

abstract class MoreRemoteDataSource {
  Future<TermsResponse> getTerms();
}

class MoreRemoteDataSourceImpl implements MoreRemoteDataSource {
  final Dio dio;

  MoreRemoteDataSourceImpl({Dio? dio}) : dio = dio ?? DioApiManager().dio;

  @override
  Future<TermsResponse> getTerms() async {
    final res = await dio.get('/terms_conditions');
    return TermsResponse.fromJson(res.data);
  }
}
