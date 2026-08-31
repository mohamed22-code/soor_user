import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/booking_request.dart';
import '../../data/repositories/services_repository.dart';
import 'services_state.dart';

class ServicesCubit extends Cubit<ServicesState> {
  final ServicesRepository repository;

  ServicesCubit({ServicesRepository? repository})
    : repository = repository ?? ServicesRepository(),
      super(const ServicesInitial());

  Future<void> fetchAll({int perPage = 1000}) async {
    emit(const ServicesLoading());
    final (servicesRes, fail1) = await repository.getAllServices(
      perPage: perPage,
    );
    if (fail1 != null) {
      emit(ServicesError(fail1.message));
      return;
    }
    final (periodsRes, _) = await repository.getWorkPeriods();
    final (priceRes, _) = await repository.getHourPrice();
    emit(
      ServicesLoaded(
        services: servicesRes?.data ?? [],
        periods: periodsRes?.data ?? [],
        hourPrice: priceRes,
      ),
    );
  }

  Future<void> fetchPeriodsAndPrice() async {
    final (periodsRes, _) = await repository.getWorkPeriods();
    final (priceRes, _) = await repository.getHourPrice();
    final current = state;
    if (current is ServicesLoaded) {
      emit(
        ServicesLoaded(
          services: current.services,
          periods: periodsRes?.data ?? [],
          hourPrice: priceRes,
        ),
      );
    }
  }

  Future<void> createBooking(BookingRequest req) async {
    emit(const BookingLoading());
    final (res, failure) = await repository.createBooking(req);
    if (failure != null) {
      emit(BookingError(failure.message));
    } else {
      emit(BookingSuccess(res?.message ?? 'تم إنشاء الحجز بنجاح'));
    }
  }
}
