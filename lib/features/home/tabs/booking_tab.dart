import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/themes/colors/app_colors.dart';
import '../../../core/themes/styles/app_style.dart';
import '../../../core/widgets/custom_container_booking.dart';
import '../../bookings/data/models/booking_model.dart';
import '../../bookings/presentation/cubit/bookings_cubit.dart';
import '../../bookings/presentation/cubit/bookings_state.dart';
import '../booking_details/booking_details_screen.dart';

class BookingTab extends StatefulWidget {
  const BookingTab({super.key});

  @override
  State<BookingTab> createState() => _BookingTabState();
}

class _BookingTabState extends State<BookingTab> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<BookingsCubit>().loadMore();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'قبول الحارس':
        return const Color(0xff00394C);
      case 'وصول الحارس':
        return AppColors.primaryText;
      case 'منتهي':
        return AppColors.sucessColor;
      default:
        return AppColors.grayDark100Color;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BookingsCubit()..fetchBookings(page: 1),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('الحجوزات', style: AppStyle.medium16white),
          centerTitle: true,
        ),
        body: BlocBuilder<BookingsCubit, BookingsState>(
          builder: (context, state) {
            if (state is BookingsLoading) {
              return const Center(
                child: CircularProgressIndicator(color: AppColors.primaryText),
              );
            }
            if (state is BookingsError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        state.message,
                        style: AppStyle.medium16white,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: () => context
                            .read<BookingsCubit>()
                            .fetchBookings(page: 1, refresh: true),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryText,
                        ),
                        child: const Text('إعادة المحاولة'),
                      ),
                    ],
                  ),
                ),
              );
            }
            if (state is BookingsLoaded) {
              if (state.bookings.isEmpty) {
                return RefreshIndicator(
                  color: AppColors.primaryText,
                  onRefresh: () => context.read<BookingsCubit>().fetchBookings(
                    page: 1,
                    refresh: true,
                  ),
                  child: ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    children: const [
                      SizedBox(height: 100),
                      Center(
                        child: Text(
                          'لا توجد حجوزات حالياً',
                          style: AppStyle.medium16white,
                        ),
                      ),
                    ],
                  ),
                );
              }
              return RefreshIndicator(
                color: AppColors.primaryText,
                onRefresh: () => context.read<BookingsCubit>().fetchBookings(
                  page: 1,
                  refresh: true,
                ),
                child: ListView.separated(
                  controller: _scrollController,
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.04,
                    vertical: MediaQuery.of(context).size.height * 0.02,
                  ),
                  itemCount: state.bookings.length + (state.hasMore ? 1 : 0),
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    if (index >= state.bookings.length) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: CircularProgressIndicator(
                            color: AppColors.primaryText,
                          ),
                        ),
                      );
                    }
                    final BookingModel b = state.bookings[index];
                    return InkWell(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BookingDetailsScreen(booking: b),
                        ),
                      ),
                      child: CustomContainerBooking(
                        bookingNumber: b.bookingNumber ?? '#---',
                        price: b.price ?? '---',
                        status: b.status ?? 'منتهي',
                        date: b.date ?? '---',
                        color: _statusColor(b.status ?? ''),
                        onAddReview: b.canRate == true
                            ? () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => BookingDetailsScreen(
                                    booking: b,
                                    openRating: true,
                                  ),
                                ),
                              )
                            : null,
                      ),
                    );
                  },
                ),
              );
            }
            return SizedBox();
          },
        ),
      ),
    );
  }
}
