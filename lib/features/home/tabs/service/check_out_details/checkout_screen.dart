import 'package:flutter/material.dart';

import '../../../../../core/themes/colors/app_colors.dart';
import '../../../../../core/themes/styles/app_style.dart';
import '../../../../../core/utils/app_assets.dart';
import '../../../../../core/widgets/add_time_bottom_sheet.dart';
import '../../../../../core/widgets/custom_elevated_button.dart';
import '../google_map/google_maps_screen.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int selectedPayment = 0;
  bool checkBoxValue = false;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('مراجعه التفاصيل', style: AppStyle.bold16white),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.04,
          vertical: height * 0.02,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.grayDark100Color,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 130,
                      width: double.infinity,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(14),
                            child: Container(color: AppColors.borderSideColor),
                          ),
                          const Icon(
                            Icons.location_on,
                            color: AppColors.primary600,
                            size: 34,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 10,
                      ),
                      child: Row(
                        children: [
                          TextButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const GoogleMapsScreen(),
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.edit,
                              size: 20,
                              color: AppColors.describtionColor,
                            ),
                            label: Text('تعديل', style: AppStyle.bold14white),
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: const Size(0, 0),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                          ),
                          const Spacer(),
                          Expanded(
                            flex: 3,
                            child: Text(
                              'الرياض, المملكة العربية السعوديه',
                              textAlign: TextAlign.right,
                              style: AppStyle.bold14white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: height * 0.01),
              buildBookingDetails(),
              SizedBox(height: height * 0.01),
              buildPaymentMethods(),
              SizedBox(height: height * 0.01),
              buildPaymentSummary(),
              SizedBox(height: height * 0.01),
              // buildOrderTracking(),
              SizedBox(height: height * 0.01),
              // _buildBottomButtons(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                width: double.infinity,
                height: height * 0.15,
                color: AppColors.appBarColor,
                child: Column(
                  crossAxisAlignment: .stretch,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: checkBoxValue,
                          onChanged: (v) {
                            checkBoxValue = v!;
                            setState(() {});
                          },
                        ),
                        Text('اوافق علي', style: AppStyle.medium16white),
                        Text(
                          'الشروط والاحكام',
                          style: AppStyle.medium16secondaryGrey,
                        ),
                      ],
                    ),
                    CustomElevatedButton(onPressed: () {}, text: 'الدفع'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildBookingDetails() {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: BoxBorder.all(width: 2, color: AppColors.grayDark100Color),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('تفاصيل الحجز', style: AppStyle.medium16darkGrey),
              Text('1550 ريال', style: AppStyle.bold16primary),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: infoItem(
                  title: 'وقت و تاريخ بدء الحجز',
                  value: '20/10/2026',
                ),
              ),
              Expanded(
                child: infoItem(title: 'عدد الحراس', value: '3 افراد'),
              ),
            ],
          ),
          const SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text('عرض المزيد', style: AppStyle.medium16darkGrey),
                  const SizedBox(width: 5),
                  const Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.white,
                    size: 20,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget infoItem({required String title, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppStyle.medium14darkGrey),
        const SizedBox(height: 4),
        Text(value, style: AppStyle.medium16darkGrey),
      ],
    );
  }

  Widget buildPaymentMethods() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: BoxBorder.all(width: 2, color: AppColors.grayDark100Color),
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.only(right: 5, bottom: 10),
              child: Text(
                'طرق الدفع',
                textAlign: TextAlign.right,
                style: AppStyle.bold16white,
              ),
            ),
            paymentItem(index: 0, title: 'فيزا', logo: visaLogo()),
            const SizedBox(height: 10),
            paymentItem(index: 1, title: 'أبل باي', logo: applePayLogo()),
            const SizedBox(height: 10),
            paymentItem(
              index: 2,
              title: 'مدى',
              logo: Image.asset(AppAssets.madaLogoImage),
            ),
          ],
        ),
      ),
    );
  }

  Widget paymentItem({
    required int index,
    required String title,
    required Widget logo,
  }) {
    final bool selected = selectedPayment == index;
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () {
        setState(() {
          selectedPayment = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        height: 42,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFF332500) : const Color(0xFF222222),
          borderRadius: BorderRadius.circular(9),
          border: Border.all(
            color: selected ? AppColors.primaryText : const Color(0xFF292929),
            width: selected ? 1 : .7,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: selected ? Color(0xff2D9EC4) : Colors.white,
                shape: BoxShape.circle,
              ),

              child: selected
                  ? const Icon(Icons.check, color: Colors.white, size: 14)
                  : null,
            ),
            const SizedBox(width: 7),

            Text(title, style: AppStyle.bold12white),
            const Spacer(),
            logo,
          ],
        ),
      ),
    );
  }

  Widget visaLogo() {
    return const Text(
      'VISA',
      style: TextStyle(
        color: Color(0xFF1475D1),
        fontSize: 12,
        fontWeight: FontWeight.w900,
      ),
    );
  }

  Widget applePayLogo() {
    return const Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.apple, color: Colors.white, size: 18),
        Text('Pay', style: AppStyle.bold12white),
      ],
    );
  }

  Widget madaLogo() {
    return const Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('مدى', style: AppStyle.bold12white),
        SizedBox(width: 5),
        SizedBox(
          width: 25,
          height: 5,
          child: Row(
            children: [
              Expanded(child: ColoredBox(color: Color(0xFF35A8D8))),
              Expanded(child: ColoredBox(color: Color(0xFF65B946))),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildPaymentSummary() {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: BoxBorder.all(width: 2, color: AppColors.grayDark100Color),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('ملخص الدفع', style: AppStyle.bold16white),
          const SizedBox(height: 12),
          priceRow(title: 'قيمة الطلب', price: '1500 ريال'),
          const SizedBox(height: 8),
          priceRow(title: 'رسوم الخدمة', price: '50 ريال'),
          priceRow(title: 'الاحمالي', price: '1550 ريال', isTotal: true),
        ],
      ),
    );
  }

  Widget priceRow({
    required String title,
    required String price,
    bool isTotal = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: isTotal ? AppStyle.bold16primary : AppStyle.medium14darkGrey,
        ),
        Text(
          price,
          style: isTotal ? AppStyle.bold16primary : AppStyle.medium14darkGrey,
        ),
      ],
    );
  }

  void showAddTimeBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return const AddTimeBottomSheet();
      },
    );
  }
}
