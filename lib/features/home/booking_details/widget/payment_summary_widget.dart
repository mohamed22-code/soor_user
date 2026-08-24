// import 'package:flutter/material.dart';
// import 'package:soor_user_app/features/home/booking_details/widget/price_row_widget.dart';
//
// import '../../../../core/themes/colors/app_colors.dart';
// import '../../../../core/themes/styles/app_style.dart';
//
// class PaymentSummaryWidget extends StatelessWidget {
//   const PaymentSummaryWidget({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(8),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(12),
//         border: BoxBorder.all(width: 2, color: AppColors.grayDark100Color),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           Text('ملخص الدفع', style: AppStyle.bold16white),
//           const SizedBox(height: 12),
//           PriceRowWidget(title: 'قيمة الطلب', price: '1500 ريال'),
//           const SizedBox(height: 8),
//           PriceRowWidget(title: 'رسوم الخدمة', price: '50 ريال'),
//           PriceRowWidget(title: 'الاحمالي', price: '1550 ريال', isTotal: true),
//         ],
//       ),
//     );
//   }
// }
