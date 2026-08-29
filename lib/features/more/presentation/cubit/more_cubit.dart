import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/more_repository.dart';
import 'more_state.dart';

class MoreCubit extends Cubit<MoreState> {
  final MoreRepository repository;

  MoreCubit({MoreRepository? repository})
    : repository = repository ?? MoreRepository(),
      super(const MoreInitial());

  Future<void> fetchTerms() async {
    emit(const MoreLoading());
    final (res, failure) = await repository.getTerms();
    if (failure != null) {
      emit(MoreError(failure.message));
    } else if (res != null) {
      emit(TermsLoaded(res));
    } else {
      emit(const MoreError('فشل جلب الشروط'));
    }
  }
}
