import 'package:dio/dio.dart';
import '../../../../core/error/failures.dart';
import '../datasources/more_remote_datasource.dart';
import '../models/terms_model.dart';

class MoreRepository {
  final MoreRemoteDataSource remote;

  MoreRepository({MoreRemoteDataSource? remote})
    : remote = remote ?? MoreRemoteDataSourceImpl();

  Future<(TermsResponse?, Failure?)> getTerms() async {
    try {
      final res = await remote.getTerms();
      return (res, null);
    } on DioException catch (e) {
      return (null, ServerFailure.fromDioError(e));
    } catch (e) {
      return (null, ServerFailure(e.toString()));
    }
  }
}
