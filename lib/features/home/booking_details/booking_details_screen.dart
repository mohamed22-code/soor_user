import 'package:flutter/material.dart';

import '../../../core/utils/app_assets.dart';
import '../../../core/themes/colors/app_colors.dart';
import '../../../core/themes/styles/app_style.dart';
import '../../../core/widgets/add_time_bottom_sheet.dart';
import '../../../core/widgets/custom_elevated_button.dart';

class BookingDetailsScreen extends StatefulWidget {
  const BookingDetailsScreen({super.key});

  @override
  State<BookingDetailsScreen> createState() => _BookingDetailsScreenState();
}

class _BookingDetailsScreenState extends State<BookingDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('#12336455', style: AppStyle.bold16white),
        centerTitle: true,
        actions: [
          Image.asset(AppAssets.bookingCommentImage),
          SizedBox(width: 10),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.04,
            vertical: height * 0.02,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                buildBookingDetails(),
                SizedBox(height: height * 0.01),
                buildPaymentMethod(),
                SizedBox(height: height * 0.01),
                buildPaymentSummary(),
                SizedBox(height: height * 0.01),
                buildOrderTracking(),
                SizedBox(height: height * 0.01),
                _buildBottomButtons(),
              ],
            ),
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
              CustomElevatedButton(
                onPressed: () {},
                text: 'وصول الحارس',
                backgroundColor: AppColors.primaryText,
                radius: 360,
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

  buildPaymentMethod() {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: BoxBorder.all(width: 2, color: AppColors.grayDark100Color),
      ),
      child: Row(
        mainAxisAlignment: .spaceBetween,
        children: [
          Text('طرق الدفع', style: AppStyle.bold16white),
          Text(
            'VISA',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.blue,
            ),
          ),
        ],
      ),
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

  Widget buildOrderTracking() {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: BoxBorder.all(width: 2, color: AppColors.grayDark100Color),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('متابعة الطلب', style: AppStyle.bold16white),
          const SizedBox(height: 15),
          timelineItem(
            title: 'قبول الحارس',
            subtitle: 'هنا يكتب الوصف',
            isCompleted: true,
            isCurrent: false,
          ),
          timelineItem(
            title: 'وصول الحارس',
            subtitle: 'هنا يكتب الوصف',
            isCompleted: false,
            isCurrent: true,
          ),

          timelineItem(
            title: 'تم الانتهاء',
            subtitle: 'هنا يكتب الوصف',
            isCompleted: false,
            isCurrent: false,
            isLast: true,
          ),
        ],
      ),
    );
  }

  Widget timelineItem({
    required String title,
    required String subtitle,
    required bool isCompleted,
    required bool isCurrent,
    bool isLast = false,
  }) {
    return SizedBox(
      height: 65,
      child: Row(
        children: [
          SizedBox(
            width: 30,
            child: Column(
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    borderRadius: .circular(12),
                    color: isCompleted || isCurrent
                        ? Color(0xff2D9EC4)
                        : Color(0xff00394C),
                  ),
                  child: isCompleted
                      ? Icon(Icons.check, color: Colors.white, size: 14)
                      : isCurrent
                      ? Container(
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white,
                          ),
                        )
                      : null,
                ),

                if (!isLast)
                  Expanded(
                    child: Container(width: 2, color: const Color(0xff007AA2)),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 8),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: isCompleted || isCurrent
                        ? const Color(0xff0085AD)
                        : Colors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  subtitle,
                  style: const TextStyle(color: Colors.grey, fontSize: 11),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomButtons() {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 48,
            child: ElevatedButton(
              onPressed: () {
                //todo: navigate to rate
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff3D2D08),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7),
                ),
                elevation: 0,
              ),
              child: const Text(
                'تقييم',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),

        Expanded(
          child: SizedBox(
            height: 48,
            child: ElevatedButton(
              onPressed: () {
                //todo: add additional time
                showAddTimeBottomSheet(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7),
                ),
                elevation: 0,
              ),
              child: const Text(
                'مد وقت اضافي',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ],
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
