import 'package:equatable/equatable.dart';
import '../../data/models/booking_model.dart';
import '../../data/models/rating_criteria_model.dart';

abstract class BookingsState extends Equatable {
  const BookingsState();

  @override
  List<Object?> get props => [];
}

class BookingsInitial extends BookingsState {
  const BookingsInitial();
}

class BookingsLoading extends BookingsState {
  const BookingsLoading();
}

class BookingsLoaded extends BookingsState {
  final List<BookingModel> bookings;
  final int currentPage;
  final int lastPage;
  final bool hasMore;

  const BookingsLoaded({
    required this.bookings,
    this.currentPage = 1,
    this.lastPage = 1,
    this.hasMore = false,
  });

  @override
  List<Object?> get props => [bookings, currentPage, lastPage, hasMore];
}

class BookingsError extends BookingsState {
  final String message;

  const BookingsError(this.message);

  @override
  List<Object?> get props => [message];
}

class RatingCriteriaLoading extends BookingsState {
  const RatingCriteriaLoading();
}

class RatingCriteriaLoaded extends BookingsState {
  final List<RatingCriteriaModel> criteria;

  const RatingCriteriaLoaded(this.criteria);

  @override
  List<Object?> get props => [criteria];
}

class RatingSubmitting extends BookingsState {
  const RatingSubmitting();
}

class RatingSuccess extends BookingsState {
  final String message;

  const RatingSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class RatingError extends BookingsState {
  final String message;

  const RatingError(this.message);

  @override
  List<Object?> get props => [message];
}
