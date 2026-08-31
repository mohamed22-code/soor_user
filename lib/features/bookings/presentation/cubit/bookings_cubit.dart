import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/bookings_repository.dart';
import 'bookings_state.dart';
import '../../data/models/booking_model.dart';
import '../../data/models/rating_criteria_model.dart';

class BookingsCubit extends Cubit<BookingsState> {
  final BookingsRepository repository;

  BookingsCubit({BookingsRepository? repository})
    : repository = repository ?? BookingsRepository(),
      super(const BookingsInitial());

  List<BookingModel> _all = [];
  int _currentPage = 1;
  int _lastPage = 1;
  List<RatingCriteriaModel> _criteria = [];

  List<RatingCriteriaModel> get criteria => _criteria;

  Future<void> fetchBookings({int page = 1, bool refresh = false}) async {
    if (refresh) {
      _all = [];
      _currentPage = 1;
      _lastPage = 1;
    }
    if (page == 1) emit(const BookingsLoading());
    final (res, failure) = await repository.getBookings(page: page);
    if (failure != null) {
      emit(BookingsError(failure.message));
    } else if (res != null) {
      if (page == 1) {
        _all = res.data;
      } else {
        _all.addAll(res.data);
      }
      _currentPage = res.currentPage ?? page;
      _lastPage = res.lastPage ?? page;
      emit(
        BookingsLoaded(
          bookings: List.from(_all),
          currentPage: _currentPage,
          lastPage: _lastPage,
          hasMore: _currentPage < _lastPage,
        ),
      );
    }
  }

  Future<void> loadMore() async {
    if (_currentPage >= _lastPage) return;
    await fetchBookings(page: _currentPage + 1);
  }

  Future<void> fetchCriteria() async {
    emit(const RatingCriteriaLoading());
    final (res, failure) = await repository.getRatingCriteria();
    if (failure != null) {
      emit(RatingError(failure.message));
    } else {
      _criteria = res?.data ?? [];
      emit(RatingCriteriaLoaded(_criteria));
    }
  }

  Future<void> submitRating({
    required int bookingId,
    required Map<String, int> ratings,
  }) async {
    emit(const RatingSubmitting());
    final (res, failure) = await repository.rateGuard(
      bookingId: bookingId,
      ratings: ratings,
    );
    if (failure != null) {
      emit(RatingError(failure.message));
    } else {
      emit(RatingSuccess(res?['message']?.toString() ?? 'تم التقييم بنجاح'));
      await fetchBookings(page: 1, refresh: true);
    }
  }
}
