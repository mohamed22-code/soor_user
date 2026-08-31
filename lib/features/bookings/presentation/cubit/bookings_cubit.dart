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

  // virtual bookings
  List<BookingModel> _dummyBookings() =>
      [
        BookingModel(id: 101,
            bookingNumber: '#12336455',
            status: 'قبول الحارس',
            date: 'اليوم 8:00 م الى 11:00 م',
            price: '1600 ريال',
            guardsCount: '2',
            durationHours: '4',
            address: 'الرياض - حي العليا',
            paymentMethod: 'VISA',
            canRate: false),
        BookingModel(id: 102,
            bookingNumber: '#12336456',
            status: 'وصول الحارس',
            date: 'غدا 9:00 م الى 12:00 ص',
            price: '1800 ريال',
            guardsCount: '3',
            durationHours: '3',
            address: 'الرياض - حي النخيل',
            paymentMethod: 'mada',
            canRate: false),
        BookingModel(id: 103,
            bookingNumber: '#12336457',
            status: 'منتهي',
            date: 'أمس 6:00 م الى 9:00 م',
            price: '1500 ريال',
            guardsCount: '1',
            durationHours: '5',
            address: 'جدة - حي الحمراء',
            paymentMethod: 'VISA',
            canRate: true),
        BookingModel(id: 104,
            bookingNumber: '#12336458',
            status: 'منتهي',
            date: '2026/08/20 2:00 م',
            price: '2200 ريال',
            guardsCount: '4',
            durationHours: '6',
            address: 'الدمام - الكورنيش',
            paymentMethod: 'apple_pay',
            canRate: true),
      ];

  Future<void> fetchBookings({int page = 1, bool refresh = false}) async {
    if (refresh) {
      _all = [];
      _currentPage = 1;
      _lastPage = 1;
    }
    if (page == 1) emit(const BookingsLoading());
    final (res, failure) = await repository.getBookings(page: page);
    if (failure != null) {
      if (_all.isEmpty) {
        _all = _dummyBookings();
        emit(BookingsLoaded(bookings: List.from(_all),
            currentPage: 1,
            lastPage: 1,
            hasMore: false));
      } else {
        emit(BookingsError(failure.message));
      }
    } else if (res != null) {
      if (res.data.isEmpty && page == 1 && _all.isEmpty) {
        _all = _dummyBookings();
      } else {
        if (page == 1) {
          _all = res.data;
        } else {
          _all.addAll(res.data);
        }
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


  void addDummyBooking() {
    final dummy = BookingModel(
      id: DateTime
          .now()
          .millisecondsSinceEpoch % 100000,
      bookingNumber: '#${DateTime
          .now()
          .millisecondsSinceEpoch % 100000}',
      status: 'قبول الحارس',
      date: 'الآن ${DateTime
          .now()
          .hour}:${DateTime
          .now()
          .minute
          .toString()
          .padLeft(2, '0')}',
      price: '1600 ريال',
      guardsCount: '2',
      durationHours: '4',
      address: 'الرياض - وهمي',
      canRate: false,
    );
    _all.insert(0, dummy);
    emit(BookingsLoaded(bookings: List.from(_all),
        currentPage: _currentPage,
        lastPage: _lastPage,
        hasMore: _currentPage < _lastPage));
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
