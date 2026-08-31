import 'package:equatable/equatable.dart';
import '../../../home/data/models/service_model.dart';
import '../../data/models/work_period_model.dart';
import '../../data/models/hour_price_model.dart';

abstract class ServicesState extends Equatable {
  const ServicesState();

  @override
  List<Object?> get props => [];
}

class ServicesInitial extends ServicesState {
  const ServicesInitial();
}

class ServicesLoading extends ServicesState {
  const ServicesLoading();
}

class ServicesLoaded extends ServicesState {
  final List<ServiceModel> services;
  final List<WorkPeriodModel> periods;
  final HourPriceModel? hourPrice;

  const ServicesLoaded({
    required this.services,
    this.periods = const [],
    this.hourPrice,
  });

  @override
  List<Object?> get props => [services, periods, hourPrice];
}

class ServicesError extends ServicesState {
  final String message;

  const ServicesError(this.message);

  @override
  List<Object?> get props => [message];
}

class BookingLoading extends ServicesState {
  const BookingLoading();
}

class BookingSuccess extends ServicesState {
  final String message;

  const BookingSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class BookingError extends ServicesState {
  final String message;

  const BookingError(this.message);

  @override
  List<Object?> get props => [message];
}
