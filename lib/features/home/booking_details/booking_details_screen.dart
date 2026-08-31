import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/app_assets.dart';
import '../../../core/themes/colors/app_colors.dart';
import '../../../core/themes/styles/app_style.dart';
import '../../../core/widgets/add_time_bottom_sheet.dart';
import '../../../core/widgets/custom_elevated_button.dart';
import '../../bookings/data/models/booking_model.dart';
import '../../bookings/presentation/cubit/bookings_cubit.dart';
import '../../bookings/presentation/cubit/bookings_state.dart';

class BookingDetailsScreen extends StatefulWidget {
  final BookingModel? booking;
  final bool openRating;

  const BookingDetailsScreen(
      {super.key, this.booking, this.openRating = false});

  @override
  State<BookingDetailsScreen> createState() => _BookingDetailsScreenState();
}

class _BookingDetailsScreenState extends State<BookingDetailsScreen> {
  @override
  void initState() {
    super.initState();
    if (widget.openRating) {
      WidgetsBinding.instance.addPostFrameCallback((_) =>
          _showRatingSheet(context));
    }
  }

  BookingModel get _b =>
      widget.booking ??
          BookingModel(
            id: 1,
            bookingNumber: '#12336455',
            status: 'منتهي',
            date: '20/10/2026',
            price: '1550 ريال',
            guardsCount: '3',
            durationHours: '3',
            address: 'الرياض',
          );

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (_) =>
      BookingsCubit()
        ..fetchCriteria(),
      child: BlocListener<BookingsCubit, BookingsState>(
        listener: (context, state) {
          if (state is RatingSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)));
            Navigator.pop(context);
          } else if (state is RatingError) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)));
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(
                _b.bookingNumber ?? '#---', style: AppStyle.bold16white),
            centerTitle: true,
            actions: [
              Image.asset(AppAssets.bookingCommentImage),
              const SizedBox(width: 10)
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: width * 0.04, vertical: height * 0.02),
              child: SingleChildScrollView(
                child: Column(children: [
                  _buildBookingDetails(),
                  SizedBox(height: height * 0.01),
                  _buildPaymentMethod(),
                  SizedBox(height: height * 0.01),
                  _buildPaymentSummary(),
                  SizedBox(height: height * 0.01),
                  _buildOrderTracking(),
                  SizedBox(height: height * 0.01),
                  _buildBottomButtons(),
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBookingDetails() {
    final b = _b;
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),
          border: Border.all(width: 2, color: AppColors.grayDark100Color)),
      child: Column(children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('تفاصيل الحجز', style: AppStyle.medium16darkGrey),
              Text(b.price ?? '1550 ريال', style: AppStyle.bold16primary)
            ]),
        const SizedBox(height: 12),
        Row(children: [
          Expanded(child: infoItem(
              title: 'وقت و تاريخ بدء الحجز', value: b.date ?? '---')),
          Expanded(child: infoItem(title: 'عدد الحراس',
              value: b.guardsCount != null
                  ? '${b.guardsCount} افراد'
                  : '3 افراد'))
        ]),
        const SizedBox(height: 10),
        if (b.address != null) ...[
          Row(children: [
            const Icon(
                Icons.location_on, size: 16, color: AppColors.describtionColor),
            const SizedBox(width: 4),
            Expanded(child: Text(b.address!, style: AppStyle.medium14darkGrey))
          ]),
          const SizedBox(height: 10),
        ],
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Row(children: [
            const Text('عرض المزيد', style: AppStyle.medium16darkGrey),
            const SizedBox(width: 5),
            const Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 20)
          ]),
          CustomElevatedButton(onPressed: () {},
              text: b.status ?? 'وصول الحارس',
              backgroundColor: _statusColor(b.status),
              radius: 360),
        ]),
      ]),
    );
  }

  Color _statusColor(String? s) {
    switch (s) {
      case 'قبول الحارس':
        return const Color(0xff00394C);
      case 'وصول الحارس':
        return AppColors.primaryText;
      case 'منتهي':
        return AppColors.sucessColor;
      default:
        return AppColors.primaryText;
    }
  }

  Widget infoItem({required String title, required String value}) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppStyle.medium14darkGrey),
          const SizedBox(height: 4),
          Text(value, style: AppStyle.medium16darkGrey)
        ]);
  }

  Widget _buildPaymentMethod() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),
          border: Border.all(width: 2, color: AppColors.grayDark100Color)),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        const Text('طرق الدفع', style: AppStyle.bold16white),
        Text(_b.paymentMethod ?? 'VISA', style: const TextStyle(
            fontSize: 14, fontWeight: FontWeight.w600, color: Colors.blue)),
      ]),
    );
  }

  Widget _buildPaymentSummary() {
    final price = _b.price ?? '1500 ريال';
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),
          border: Border.all(width: 2, color: AppColors.grayDark100Color)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        const Text('ملخص الدفع', style: AppStyle.bold16white),
        const SizedBox(height: 12),
        priceRow(title: 'قيمة الطلب', price: price),
        const SizedBox(height: 8),
        priceRow(title: 'رسوم الخدمة', price: '50 ريال'),
        priceRow(
            title: 'الاحمالي', price: _b.price ?? '1550 ريال', isTotal: true),
      ]),
    );
  }

  Widget _buildOrderTracking() {
    final status = _b.status;
    bool c1 = true,
        cur1 = false,
        c2 = false,
        cur2 = false,
        c3 = false;
    if (status == 'قبول الحارس') {
      c1 = true;
      cur2 = false;
      c2 = false;
      cur2 = false;
    } else if (status == 'وصول الحارس') {
      c1 = true;
      c2 = false;
      cur2 = true;
    } else if (status == 'منتهي') {
      c1 = true;
      c2 = true;
      c3 = true;
    }
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),
          border: Border.all(width: 2, color: AppColors.grayDark100Color)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        const Text('متابعة الطلب', style: AppStyle.bold16white),
        const SizedBox(height: 15),
        timelineItem(title: 'قبول الحارس',
            subtitle: 'تم قبول طلبك',
            isCompleted: c1,
            isCurrent: cur1),
        timelineItem(title: 'وصول الحارس',
            subtitle: 'الحارس في الطريق',
            isCompleted: c2,
            isCurrent: cur2),
        timelineItem(title: 'تم الانتهاء',
            subtitle: 'اكتملت الخدمة',
            isCompleted: c3,
            isCurrent: false,
            isLast: true),
      ]),
    );
  }

  Widget timelineItem(
      {required String title, required String subtitle, required bool isCompleted, required bool isCurrent, bool isLast = false}) {
    return SizedBox(
      height: 65,
      child: Row(children: [
        SizedBox(
          width: 30,
          child: Column(children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),
                  color: isCompleted || isCurrent
                      ? const Color(0xff2D9EC4)
                      : const Color(0xff00394C)),
              child: isCompleted ? const Icon(
                  Icons.check, color: Colors.white, size: 14) : isCurrent
                  ? Container(margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white))
                  : null,
            ),
            if (!isLast) Expanded(
                child: Container(width: 2, color: const Color(0xff007AA2))),
          ]),
        ),
        const SizedBox(width: 8),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(color: isCompleted || isCurrent
                  ? const Color(0xff0085AD)
                  : Colors.grey, fontSize: 14, fontWeight: FontWeight.bold)),
              const SizedBox(height: 3),
              Text(subtitle,
                  style: const TextStyle(color: Colors.grey, fontSize: 11))
            ])),
      ]),
    );
  }

  Widget _buildBottomButtons() {
    final canRate = _b.canRate == true || _b.status == 'منتهي';
    return Row(children: [
      Expanded(
        child: SizedBox(
          height: 48,
          child: ElevatedButton(
            onPressed: canRate ? () => _showRatingSheet(context) : null,
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff3D2D08),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7)),
                elevation: 0),
            child: const Text('تقييم',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          ),
        ),
      ),
      const SizedBox(width: 12),
      Expanded(
        child: SizedBox(
          height: 48,
          child: ElevatedButton(
            onPressed: () => showAddTimeBottomSheet(context),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7)),
                elevation: 0),
            child: const Text('مد وقت اضافي',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          ),
        ),
      ),
    ]);
  }

  Widget priceRow(
      {required String title, required String price, bool isTotal = false}) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: isTotal ? AppStyle.bold16primary : AppStyle
              .medium14darkGrey),
          Text(price, style: isTotal ? AppStyle.bold16primary : AppStyle
              .medium14darkGrey)
        ]);
  }

  void showAddTimeBottomSheet(BuildContext context) {
    showModalBottomSheet(context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => const AddTimeBottomSheet());
  }

  void _showRatingSheet(BuildContext context) {
    final cubit = context.read<BookingsCubit>();
    if (cubit.criteria.isEmpty) cubit.fetchCriteria();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.appBarColor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (sheetCtx) {
        return BlocProvider.value(
          value: cubit,
          child: BlocBuilder<BookingsCubit, BookingsState>(
            builder: (context, state) {
              final criteria = cubit.criteria;
              if (criteria.isEmpty && state is RatingCriteriaLoading) {
                return const Padding(padding: EdgeInsets.all(24),
                    child: Center(child: CircularProgressIndicator(
                        color: AppColors.primaryText)));
              }
              if (criteria.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    const Text(
                        'لا توجد معايير تقييم', style: AppStyle.medium16white),
                    const SizedBox(height: 12),
                    ElevatedButton(onPressed: () => cubit.fetchCriteria(),
                        child: const Text('إعادة المحاولة')),
                  ]),
                );
              }
              return _RatingSheetContent(
                  bookingId: _b.id ?? 1, criteria: criteria);
            },
          ),
        );
      },
    );
  }
}

class _RatingSheetContent extends StatefulWidget {
  final int bookingId;
  final List<dynamic> criteria;

  const _RatingSheetContent({required this.bookingId, required this.criteria});

  @override
  State<_RatingSheetContent> createState() => _RatingSheetContentState();
}

class _RatingSheetContentState extends State<_RatingSheetContent> {
  final Map<String, int> ratings = {};

  @override
  void initState() {
    super.initState();
    for (var c in widget.criteria) {
      ratings[c.id.toString()] = 5;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery
          .of(context)
          .viewInsets
          .bottom, top: 16, left: 16, right: 16),
      child: Column(mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('تقييم الحارس', style: AppStyle.bold16white,
                textAlign: TextAlign.center),
            const SizedBox(height: 12),
            ...widget.criteria.map((c) {
              final idStr = c.id.toString();
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(c.name, style: AppStyle.medium16white),
                      Row(
                        children: List.generate(5, (i) {
                          final selected = (ratings[idStr] ?? 5) > i;
                          return InkWell(
                            onTap: () => setState(() => ratings[idStr] = i + 1),
                            child: Icon(Icons.star,
                                color: selected ? Colors.orange : Colors.grey,
                                size: 28),
                          );
                        }),
                      ),
                    ]),
              );
            }),
            const SizedBox(height: 16),
            BlocBuilder<BookingsCubit, BookingsState>(
              builder: (context, state) {
                final loading = state is RatingSubmitting;
                return loading
                    ? const Center(child: CircularProgressIndicator(
                    color: AppColors.primaryText))
                    : SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () =>
                        context.read<BookingsCubit>().submitRating(
                        bookingId: widget.bookingId, ratings: ratings),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryText),
                    child: const Text('إرسال التقييم'),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
          ]),
    );
  }
}
