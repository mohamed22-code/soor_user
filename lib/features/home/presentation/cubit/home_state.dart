import 'package:equatable/equatable.dart';
import '../../data/models/slider_model.dart';
import '../../data/models/service_model.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {
  const HomeInitial();
}

class HomeLoading extends HomeState {
  const HomeLoading();
}

class HomeLoaded extends HomeState {
  final List<SliderModel> sliders;
  final List<ServiceModel> services;

  const HomeLoaded({required this.sliders, required this.services});

  @override
  List<Object?> get props => [sliders, services];
}

class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);

  @override
  List<Object?> get props => [message];
}
