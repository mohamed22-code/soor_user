import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/themes/colors/app_colors.dart';
import '../../../../../core/themes/styles/app_style.dart';
import '../../../../../core/utils/app_assets.dart';
import '../../../../../core/widgets/add_time_bottom_sheet.dart';
import '../../../../../core/widgets/custom_elevated_button.dart';
import '../../../../services/data/models/booking_request.dart';
import '../../../../services/presentation/cubit/services_cubit.dart';
import '../../../../services/presentation/cubit/services_state.dart';
import '../google_map/google_maps_screen.dart';

class CheckoutScreen extends StatefulWidget {
  final Map<String, dynamic>? draft;

  const CheckoutScreen({super.key, this.draft});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int selectedPayment = 0;
  bool checkBoxValue = false;
  String selectedAddress = 'الرياض, المملكة العربية السعوديه';
  double lat = 24.7136;
  double lng = 46.6753;

  String get paymentMethod {
    switch (selectedPayment) {
      case 0:
        return 'visa';
      case 1:
        return 'apple_pay';
      case 2:
        return 'mada';
      default:
        return 'cash';
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    final draft = widget.draft;
    return BlocProvider(
      create: (_) => ServicesCubit(),
      child: BlocConsumer<ServicesCubit, ServicesState>(
        listener: (context, state) {
          if (state is BookingSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)));
            Navigator.of(context).popUntil((r) => r.isFirst);
          } else if (state is BookingError) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          final isBooking = state is BookingLoading;
          return Scaffold(
            appBar: AppBar(title: const Text(
                'مراجعه التفاصيل', style: AppStyle.bold16white),
                centerTitle: true),
            body: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: width * 0.04, vertical: height * 0.02),
              child: SingleChildScrollView(
                child: Column(children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(color: AppColors.grayDark100Color,
                        borderRadius: BorderRadius.circular(14)),
                    child: Column(children: [
                      SizedBox(height: 130,
                          width: double.infinity,
                          child: Stack(alignment: Alignment.center,
                              children: [
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(14),
                                    child: Container(
                                        color: AppColors.borderSideColor)),
                                const Icon(Icons.location_on,
                                    color: AppColors.primary600, size: 34)
                              ])),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 10),
                        child: Row(children: [
                          TextButton.icon(
                            onPressed: () async {
                              final res = await Navigator.push(context,
                                  MaterialPageRoute(builder: (
                                      _) => const GoogleMapsScreen()));
                              if (res is String) setState(() =>
                              selectedAddress = res);
                            },
                            icon: const Icon(Icons.edit, size: 20,
                                color: AppColors.describtionColor),
                            label: const Text(
                                'تعديل', style: AppStyle.bold14white),
                            style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: const Size(0, 0),
                                tapTargetSize: MaterialTapTargetSize
                                    .shrinkWrap),
                          ),
                          const Spacer(),
                          Expanded(flex: 3,
                              child: Text(
                                  selectedAddress, textAlign: TextAlign.right,
                                  style: AppStyle.bold14white)),
                        ]),
                      ),
                    ]),
                  ),
                  SizedBox(height: height * 0.01),
                  _buildBookingDetails(draft),
                  SizedBox(height: height * 0.01),
                  buildPaymentMethods(),
                  SizedBox(height: height * 0.01),
                  _buildPaymentSummary(draft),
                  SizedBox(height: height * 0.01),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                    width: double.infinity,
                    height: height * 0.15,
                    color: AppColors.appBarColor,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(children: [
                            Checkbox(value: checkBoxValue,
                                onChanged: (v) =>
                                    setState(() => checkBoxValue = v!)),
                            const Text(
                                'اوافق علي', style: AppStyle.medium16white),
                            const Text('الشروط والاحكام',
                                style: AppStyle.medium16secondaryGrey),
                          ]),
                          isBooking
                              ? const Center(child: CircularProgressIndicator(
                              color: AppColors.primaryText))
                              : CustomElevatedButton(
                            onPressed: () {
                              if (!checkBoxValue) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text(
                                        'يجب الموافقة على الشروط')));
                                return;
                              }
                              if (draft == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text(
                                        'بيانات الحجز غير مكتملة')));
                                return;
                              }
                              final req = BookingRequest(
                                serviceId: draft['service_id'].toString(),
                                lat: lat.toString(),
                                long: lng.toString(),
                                areaName: 'Al Olaya',
                                buildingName: 'Tower 1',
                                floor: '5',
                                addressDetails: selectedAddress,
                                city: 'Riyadh',
                                region: 'Saudi Arabia',
                                street: 'King Fahd Road',
                                startDatetime: draft['start_datetime']
                                    .toString(),
                                durationHours: draft['duration_hours']
                                    .toString(),
                                guardsCount: draft['guards_count'].toString(),
                                dressType: draft['dress_type'].toString(),
                                language: draft['language'].toString(),
                                hasCoordinator: draft['has_coordinator']
                                    .toString(),
                                coordinatorName: draft['coordinator_name']
                                    ?.toString()
                                    .isEmpty == true
                                    ? null
                                    : draft['coordinator_name'].toString(),
                                coordinatorPhone: draft['coordinator_phone']
                                    ?.toString()
                                    .isEmpty == true
                                    ? null
                                    : draft['coordinator_phone'].toString(),
                                additionalNotes: draft['additional_notes']
                                    ?.toString()
                                    .isEmpty == true
                                    ? null
                                    : draft['additional_notes'].toString(),
                                paymentMethod: paymentMethod,
                              );
                              context.read<ServicesCubit>().createBooking(req);
                            },
                            text: 'الدفع',
                          ),
                        ]),
                  ),
                ]),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBookingDetails(Map<String, dynamic>? draft) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),
          border: Border.all(width: 2, color: AppColors.grayDark100Color)),
      child: Column(children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('تفاصيل الحجز', style: AppStyle.medium16darkGrey),
              Text('${draft?['total_price'] ?? '1550'} ريال',
                  style: AppStyle.bold16primary)
            ]),
        const SizedBox(height: 12),
        Row(children: [
          Expanded(child: infoItem(title: 'وقت و تاريخ بدء الحجز',
              value: draft?['start_datetime']?.toString() ?? '20/10/2026')),
          Expanded(child: infoItem(title: 'عدد الحراس',
              value: '${draft?['guards_count'] ?? '3'} افراد'))
        ]),
        const SizedBox(height: 10),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [
                const Text('عرض المزيد', style: AppStyle.medium16darkGrey),
                const SizedBox(width: 5),
                const Icon(
                    Icons.keyboard_arrow_down, color: Colors.white, size: 20)
              ])
            ]),
        if (draft != null) ...[
          const SizedBox(height: 8),
          Text('الخدمة: ${draft['service_name'] ??
              draft['service_id']} | ${draft['dress_type']} | ${draft['language']}',
              style: AppStyle.medium14darkGrey, textAlign: TextAlign.right),
        ],
      ]),
    );
  }

  Widget infoItem({required String title, required String value}) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppStyle.medium14darkGrey),
          const SizedBox(height: 4),
          Text(value, style: AppStyle.medium16darkGrey)
        ]);
  }

  Widget buildPaymentMethods() {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),
          border: Border.all(width: 2, color: AppColors.grayDark100Color)),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          const Padding(padding: EdgeInsets.only(right: 5, bottom: 10),
              child: Text('طرق الدفع', textAlign: TextAlign.right,
                  style: AppStyle.bold16white)),
          paymentItem(index: 0, title: 'فيزا', logo: visaLogo()),
          const SizedBox(height: 10),
          paymentItem(index: 1, title: 'أبل باي', logo: applePayLogo()),
          const SizedBox(height: 10),
          paymentItem(index: 2,
              title: 'مدى',
              logo: Image.asset(AppAssets.madaLogoImage)),
        ]),
      ),
    );
  }

  Widget paymentItem(
      {required int index, required String title, required Widget logo}) {
    final bool selected = selectedPayment == index;
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () => setState(() => selectedPayment = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        height: 42,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
            color: selected ? const Color(0xFF332500) : const Color(0xFF222222),
            borderRadius: BorderRadius.circular(9),
            border: Border.all(
                color: selected ? AppColors.primaryText : const Color(
                    0xFF292929), width: selected ? 1 : .7)),
        child: Row(children: [
          Container(width: 20,
              height: 20,
              decoration: BoxDecoration(
                  color: selected ? const Color(0xff2D9EC4) : Colors.white,
                  shape: BoxShape.circle),
              child: selected ? const Icon(
                  Icons.check, color: Colors.white, size: 14) : null),
          const SizedBox(width: 7),
          Text(title, style: AppStyle.bold12white),
          const Spacer(),
          logo,
        ]),
      ),
    );
  }

  Widget visaLogo() =>
      const Text('VISA', style: TextStyle(
          color: Color(0xFF1475D1), fontSize: 12, fontWeight: FontWeight.w900));

  Widget applePayLogo() =>
      const Row(mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.apple, color: Colors.white, size: 18),
            Text('Pay', style: AppStyle.bold12white)
          ]);

  Widget madaLogo() =>
      const Row(mainAxisSize: MainAxisSize.min,
          children: [
            Text('مدى', style: AppStyle.bold12white),
            SizedBox(width: 5),
            SizedBox(width: 25,
                height: 5,
                child: Row(children: [
                  Expanded(child: ColoredBox(color: Color(0xFF35A8D8))),
                  Expanded(child: ColoredBox(color: Color(0xFF65B946)))
                ])),
          ]);

  Widget _buildPaymentSummary(Map<String, dynamic>? draft) {
    final total = draft?['total_price'] ?? '1550';
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),
          border: Border.all(width: 2, color: AppColors.grayDark100Color)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        const Text('ملخص الدفع', style: AppStyle.bold16white),
        const SizedBox(height: 12),
        priceRow(title: 'قيمة الطلب', price: '$total ريال'),
        const SizedBox(height: 8),
        priceRow(title: 'رسوم الخدمة', price: '50 ريال'),
        priceRow(title: 'الاحمالي',
            price: '${(int.tryParse(total.toString()) ?? 1550) + 50} ريال',
            isTotal: true),
      ]),
    );
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
}
