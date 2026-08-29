import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/home_repository.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepository repository;

  HomeCubit({HomeRepository? repository})
    : repository = repository ?? HomeRepository(),
      super(const HomeInitial());

  Future<void> fetchHome({int perPage = 5}) async {
    emit(const HomeLoading());
    final result = await repository.getHomeData(perPage: perPage);
    if (result.failure != null) {
      emit(HomeError(result.failure!.message));
    } else {
      emit(
        HomeLoaded(
          sliders: result.sliders?.data ?? [],
          services: result.services?.data ?? [],
        ),
      );
    }
  }

  Future<void> refresh({int perPage = 5}) => fetchHome(perPage: perPage);
}
