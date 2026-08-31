import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soor_user_app/core/themes/styles/app_style.dart';
import 'package:soor_user_app/features/home/tabs/service/add_details/section_container.dart';
import 'package:soor_user_app/features/home/tabs/service/add_details/section_title.dart';
import 'package:soor_user_app/features/home/tabs/service/check_out_details/checkout_screen.dart';
import '../../../../services/presentation/cubit/services_cubit.dart';
import '../../../../services/presentation/cubit/services_state.dart';
import 'choice_button.dart';
import 'counter.dart';
import 'date_field.dart';

class AddDetailsScreen extends StatefulWidget {
  final String? serviceId;
  final String? serviceName;
  final String? hourPrice;

  const AddDetailsScreen(
      {super.key, this.serviceId, this.serviceName, this.hourPrice});

  @override
  State<AddDetailsScreen> createState() => _AddDetailsScreenState();
}

class _AddDetailsScreenState extends State<AddDetailsScreen> {
  int guardsCount = 3;
  int serviceHours = 3;
  String selectedUniform = 'رسمي';
  String selectedLanguage = 'عربي';
  String selectedCoordinated = 'نعم';
  final TextEditingController dateController = TextEditingController();
  final TextEditingController notesController = TextEditingController();
  final TextEditingController coordinatorNameController = TextEditingController();
  final TextEditingController coordinatorPhoneController = TextEditingController();

  @override
  void dispose() {
    dateController.dispose();
    notesController.dispose();
    coordinatorNameController.dispose();
    coordinatorPhoneController.dispose();
    super.dispose();
  }

  String get dressApiValue {
    switch (selectedUniform) {
      case 'كاجوال':
        return 'Casual';
      case 'فول سوت':
        return 'Full Suit';
      case 'رسمي':
      default:
        return 'Formal';
    }
  }

  double get hourPriceDouble => double.tryParse(widget.hourPrice ?? '0') ?? 0;

  double get totalPrice =>
      guardsCount * serviceHours *
      (hourPriceDouble == 0 ? 100 : hourPriceDouble);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (_) =>
      ServicesCubit()
        ..fetchPeriodsAndPrice(),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(elevation: 0,
              centerTitle: true,
              title: Text(widget.serviceName ?? 'التفاصيل',
                  style: AppStyle.medium16white)),
          body: BlocBuilder<ServicesCubit, ServicesState>(
            builder: (context, state) {
              String? fetchedPrice;
              if (state is ServicesLoaded)
                fetchedPrice = state.hourPrice?.hourPrice;
              final displayPrice = fetchedPrice ?? widget.hourPrice;
              final priceVal = double.tryParse(displayPrice ?? '0') ??
                  hourPriceDouble;
              final total = guardsCount * serviceHours *
                  (priceVal == 0 ? 100 : priceVal);
              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                    horizontal: width * 0.04, vertical: height * 0.02),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (widget.serviceId != null)
                      SectionContainer(child: Text('الخدمة: ${widget
                          .serviceName ?? widget.serviceId} - ${displayPrice ??
                          ''} ريال/ساعة', style: AppStyle.medium16white,
                          textAlign: TextAlign.right)),
                    SizedBox(height: height * 0.01),
                    SectionContainer(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SectionTitle(title: 'تفاصيل الحجز'),
                            SizedBox(height: height * 0.01),
                            const Text('وقت و تاريخ بدء الحجز',
                                style: AppStyle.medium16white),
                            SizedBox(height: height * 0.01),
                            DateField(controller: dateController,
                                hintText: 'مثال: 2026-09-01 14:00:00'),
                            if (state is ServicesLoaded &&
                                state.periods.isNotEmpty) ...[
                              SizedBox(height: height * 0.01),
                              const Text('الفترات المتاحة',
                                  style: AppStyle.medium16white,
                                  textAlign: TextAlign.right),
                              SizedBox(height: height * 0.01),
                              Wrap(
                                spacing: 8,
                                children: state.periods.map((p) =>
                                    ChoiceButton(
                                    title: p.displayName,
                                    selected: false,
                                    onTap: () =>
                                    dateController.text =
                                        p.startTime ?? '')).toList(),
                              ),
                            ],
                          ]),
                    ),
                    SizedBox(height: height * 0.02),
                    SectionContainer(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SectionTitle(title: 'العدد و المدة'),
                            SizedBox(height: height * 0.01),
                            const Text('عدد الحراس المطلوبين',
                                textAlign: TextAlign.right,
                                style: AppStyle.bold12white),
                            SizedBox(height: height * 0.01),
                            Counter(value: guardsCount, onMinus: () {
                              if (guardsCount >
                                  1) setState(() => guardsCount--);
                            }, onPlus: () => setState(() => guardsCount++)),
                            SizedBox(height: height * 0.01),
                            const Text('مدة الخدمة بالساعة (3 ساعات كحد أدنى)',
                                textAlign: TextAlign.right,
                                style: AppStyle.medium16white),
                            SizedBox(height: height * 0.01),
                            Counter(value: serviceHours, onMinus: () {
                              if (serviceHours >
                                  3) setState(() => serviceHours--);
                            }, onPlus: () => setState(() => serviceHours++)),
                          ]),
                    ),
                    SizedBox(height: height * 0.02),
                    SectionContainer(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SectionTitle(title: 'تفاصيل إضافية'),
                            SizedBox(height: height * 0.01),
                            const Text('نوع اللبس', textAlign: TextAlign.right,
                                style: AppStyle.medium16white),
                            SizedBox(height: height * 0.01),
                            Row(children: [
                              Expanded(child: ChoiceButton(title: 'كاجوال',
                                  selected: selectedUniform == 'كاجوال',
                                  onTap: () =>
                                      setState(() =>
                                  selectedUniform = 'كاجوال'))),
                              SizedBox(width: width * 0.01),
                              Expanded(child: ChoiceButton(title: 'فول سوت',
                                  selected: selectedUniform == 'فول سوت',
                                  onTap: () =>
                                      setState(() =>
                                  selectedUniform = 'فول سوت'))),
                              SizedBox(width: width * 0.01),
                              Expanded(child: ChoiceButton(title: 'رسمي',
                                  selected: selectedUniform == 'رسمي',
                                  onTap: () =>
                                      setState(() =>
                                  selectedUniform = 'رسمي'))),
                            ]),
                            SizedBox(height: height * 0.01),
                            const Text(
                                'اللغة المطلوبة', textAlign: TextAlign.right,
                                style: AppStyle.medium16white),
                            SizedBox(height: height * 0.01),
                            Row(children: [
                              Expanded(child: ChoiceButton(title: 'english',
                                  selected: selectedLanguage == 'english',
                                  onTap: () =>
                                      setState(() =>
                                  selectedLanguage = 'english'))),
                              SizedBox(width: width * 0.01),
                              Expanded(child: ChoiceButton(title: 'عربي',
                                  selected: selectedLanguage == 'عربي',
                                  onTap: () =>
                                      setState(() =>
                                  selectedLanguage = 'عربي'))),
                            ]),
                            SizedBox(height: height * 0.01),
                            const Text('هل يوجد منسق من طرفك',
                                textAlign: TextAlign.right,
                                style: AppStyle.medium16white),
                            SizedBox(width: width * 0.01),
                            Row(children: [
                              Expanded(child: ChoiceButton(title: 'لا',
                                  selected: selectedCoordinated == 'لا',
                                  onTap: () =>
                                      setState(() =>
                                  selectedCoordinated = 'لا'))),
                              SizedBox(width: width * 0.01),
                              Expanded(child: ChoiceButton(title: 'نعم',
                                  selected: selectedCoordinated == 'نعم',
                                  onTap: () =>
                                      setState(() =>
                                  selectedCoordinated = 'نعم'))),
                            ]),
                            if (selectedCoordinated == 'نعم') ...[
                              SizedBox(height: height * 0.01),
                              TextField(controller: coordinatorNameController,
                                  textAlign: TextAlign.right,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 11),
                                  decoration: InputDecoration(
                                      hintText: 'اسم المنسق',
                                      hintStyle: const TextStyle(
                                          color: Color(0xff666666),
                                          fontSize: 11),
                                      filled: true,
                                      fillColor: const Color(0xff222222),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              5),
                                          borderSide: BorderSide.none))),
                              SizedBox(height: height * 0.01),
                              TextField(controller: coordinatorPhoneController,
                                  textAlign: TextAlign.right,
                                  keyboardType: TextInputType.phone,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 11),
                                  decoration: InputDecoration(
                                      hintText: 'جوال المنسق +966',
                                      hintStyle: const TextStyle(
                                          color: Color(0xff666666),
                                          fontSize: 11),
                                      filled: true,
                                      fillColor: const Color(0xff222222),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              5),
                                          borderSide: BorderSide.none))),
                            ],
                            SizedBox(height: height * 0.01),
                            TextField(controller: notesController,
                                maxLines: 4,
                                textAlign: TextAlign.right,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 11),
                                decoration: InputDecoration(
                                    hintText: 'ملاحظات إضافية هنا...',
                                    hintStyle: const TextStyle(
                                        color: Color(0xff666666), fontSize: 11),
                                    filled: true,
                                    fillColor: const Color(0xff222222),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: BorderSide.none))),
                          ]),
                    ),
                    SizedBox(height: height * 0.01),
                    SizedBox(
                      height: 46,
                      child: ElevatedButton(
                        onPressed: () {
                          if (dateController.text
                              .trim()
                              .isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text(
                                    'يرجى إدخال تاريخ الحجز بصيغة 2026-09-01 14:00:00')));
                            return;
                          }
                          if (widget.serviceId == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('معرف الخدمة غير موجود')));
                            return;
                          }
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  CheckoutScreen(
                                    draft: {
                                      'service_id': widget.serviceId!,
                                      'service_name': widget.serviceName ?? '',
                                      'start_datetime': dateController.text
                                          .trim(),
                                      'duration_hours': serviceHours.toString(),
                                      'guards_count': guardsCount.toString(),
                                      'dress_type': dressApiValue,
                                      'language': selectedLanguage == 'عربي'
                                          ? 'ar'
                                          : 'en',
                                      'has_coordinator': selectedCoordinated ==
                                          'نعم' ? '1' : '0',
                                      'coordinator_name': coordinatorNameController
                                          .text.trim(),
                                      'coordinator_phone': coordinatorPhoneController
                                          .text.trim(),
                                      'additional_notes': notesController.text
                                          .trim(),
                                      'total_price': total.toStringAsFixed(0),
                                    },
                                  ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xffC58A00),
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6))),
                        child: Text('طلب (${total.toStringAsFixed(0)} ريال)',
                            style: AppStyle.medium16white),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
