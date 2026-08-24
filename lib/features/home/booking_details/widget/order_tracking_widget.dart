// import 'package:flutter/material.dart';
// import 'package:soor_user_app/features/home/booking_details/widget/time_line_widget.dart';
//
// import '../../../../core/themes/colors/app_colors.dart';
// import '../../../../core/themes/styles/app_style.dart';
//
// class OrderTrackingWidget extends StatelessWidget {
//   const OrderTrackingWidget({super.key});
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
//           Text('متابعة الطلب', style: AppStyle.bold16white),
//           const SizedBox(height: 15),
//           TimeLineWidget(
//             title: 'قبول الحارس',
//             subtitle: 'هنا يكتب الوصف',
//             isCompleted: true,
//             isCurrent: false,
//           ),
//           TimeLineWidget(
//             title: 'وصول الحارس',
//             subtitle: 'هنا يكتب الوصف',
//             isCompleted: false,
//             isCurrent: true,
//           ),
//
//           TimeLineWidget(
//             title: 'تم الانتهاء',
//             subtitle: 'هنا يكتب الوصف',
//             isCompleted: false,
//             isCurrent: false,
//             isLast: true,
//           ),
//         ],
//       ),
//     );
//   }
// }
