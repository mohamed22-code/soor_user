// import 'package:flutter/material.dart';
// import 'package:soor_user_app/features/home/booking_details/widget/info_item_widget.dart';
//
// import '../../../../core/themes/colors/app_colors.dart';
// import '../../../../core/themes/styles/app_style.dart';
// import '../../../../core/widgets/custom_elevated_button.dart';
//
// class BookingDetailsWidget extends StatelessWidget {
//   const BookingDetailsWidget({super.key});
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
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text('تفاصيل الحجز', style: AppStyle.medium16darkGrey),
//               Text('1550 ريال', style: AppStyle.bold16primary),
//             ],
//           ),
//           const SizedBox(height: 12),
//           Row(
//             children: [
//               Expanded(
//                 child: InfoItemWidget(
//                   title: 'وقت و تاريخ بدء الحجز',
//                   value: '20/10/2026',
//                 ),
//               ),
//               Expanded(
//                 child: InfoItemWidget(title: 'عدد الحراس', value: '3 افراد'),
//               ),
//             ],
//           ),
//           const SizedBox(height: 10),
//
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Row(
//                 children: [
//                   Text('عرض المزيد', style: AppStyle.medium16darkGrey),
//                   const SizedBox(width: 5),
//                   const Icon(
//                     Icons.keyboard_arrow_down,
//                     color: Colors.white,
//                     size: 20,
//                   ),
//                 ],
//               ),
//               CustomElevatedButton(
//                 onPressed: () {},
//                 text: 'وصول الحارس',
//                 backgroundColor: AppColors.primaryText,
//                 radius: 360,
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
